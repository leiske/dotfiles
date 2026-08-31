import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

type UsageLike = {
	input?: number;
	output?: number;
	cacheRead?: number;
	cacheWrite?: number;
	cost?: { total?: number };
};

type Totals = {
	input: number;
	output: number;
	cacheRead: number;
	cacheWrite: number;
	cost: number;
};

function addUsage(totals: Totals, usage: UsageLike | undefined): void {
	if (!usage) return;
	totals.input += usage.input ?? 0;
	totals.output += usage.output ?? 0;
	totals.cacheRead += usage.cacheRead ?? 0;
	totals.cacheWrite += usage.cacheWrite ?? 0;
	totals.cost += usage.cost?.total ?? 0;
}

function formatTokens(count: number): string {
	if (count < 1_000) return `${count}`;
	if (count < 10_000) return `${(count / 1_000).toFixed(1)}k`;
	if (count < 1_000_000) return `${Math.round(count / 1_000)}k`;
	return `${(count / 1_000_000).toFixed(1)}M`;
}

function formatDuration(milliseconds: number): string {
	const seconds = milliseconds / 1000;
	if (seconds < 60) return `${seconds.toFixed(1)}s`;

	const minutes = Math.floor(seconds / 60);
	return `${minutes}m ${Math.floor(seconds % 60)}s`;
}

function formatCwd(cwd: string): string {
	const home = process.env.HOME;
	if (home && (cwd === home || cwd.startsWith(`${home}/`))) {
		return `~${cwd.slice(home.length)}`;
	}
	return cwd;
}

function fitLine(left: string, right: string, width: number): string {
	if (width <= 0) return "";
	if (!right) return truncateToWidth(left, width, "...");

	const minGap = 2;
	const fittedRight = truncateToWidth(right, Math.max(0, width - minGap), "");
	const availableLeft = Math.max(0, width - visibleWidth(fittedRight) - minGap);
	const fittedLeft = truncateToWidth(left, availableLeft, "...");
	const padding = " ".repeat(Math.max(minGap, width - visibleWidth(fittedLeft) - visibleWidth(fittedRight)));
	return truncateToWidth(fittedLeft + padding + fittedRight, width, "");
}

function getTotals(ctx: ExtensionContext): Totals {
	const totals: Totals = { input: 0, output: 0, cacheRead: 0, cacheWrite: 0, cost: 0 };

	for (const entry of ctx.sessionManager.getEntries()) {
		if (entry.type === "message" && entry.message.role === "assistant") {
			addUsage(totals, entry.message.usage);
		} else if (entry.type === "message" && entry.message.role === "toolResult") {
			addUsage(totals, entry.message.usage);
		} else if (entry.type === "branch_summary" || entry.type === "compaction") {
			addUsage(totals, entry.usage);
		}
	}

	return totals;
}

export default function taskTimer(pi: ExtensionAPI) {
	let startedAt: number | undefined;
	let lastElapsed: number | undefined;
	let interval: ReturnType<typeof setInterval> | undefined;
	let requestRender: (() => void) | undefined;

	function stopInterval(): void {
		if (interval !== undefined) {
			clearInterval(interval);
			interval = undefined;
		}
	}

	function timerText(): string {
		if (startedAt !== undefined) {
			return `◷ ${formatDuration(performance.now() - startedAt)}`;
		}
		if (lastElapsed !== undefined) {
			return `✓ ${formatDuration(lastElapsed)}`;
		}
		return "";
	}

	pi.on("session_start", (_event, ctx) => {
		ctx.ui.setFooter((tui, theme, footerData) => {
			requestRender = () => tui.requestRender();
			const unsubscribe = footerData.onBranchChange(requestRender);

			return {
				dispose() {
					unsubscribe();
					requestRender = undefined;
				},
				invalidate() {},
				render(width: number): string[] {
					let location = formatCwd(ctx.cwd);
					const branch = footerData.getGitBranch();
					if (branch) location += ` (${branch})`;
					const sessionName = ctx.sessionManager.getSessionName();
					if (sessionName) location += ` • ${sessionName}`;

					const totals = getTotals(ctx);
					const stats: string[] = [];
					if (totals.input) stats.push(`↑${formatTokens(totals.input)}`);
					if (totals.output) stats.push(`↓${formatTokens(totals.output)}`);
					if (totals.cacheRead) stats.push(`R${formatTokens(totals.cacheRead)}`);
					if (totals.cacheWrite) stats.push(`W${formatTokens(totals.cacheWrite)}`);
					if (totals.cost) stats.push(`$${totals.cost.toFixed(3)}`);

					const context = ctx.getContextUsage();
					const contextWindow = context?.contextWindow ?? ctx.model?.contextWindow;
					if (contextWindow) {
						const percent = context?.percent === null || context?.percent === undefined
							? "?"
							: context.percent.toFixed(1);
						stats.push(`${percent}%/${formatTokens(contextWindow)} (auto)`);
					}

					let model = ctx.model?.id ?? "no-model";
					if (ctx.model?.reasoning) model += ` • ${pi.getThinkingLevel()}`;

					return [
						theme.fg("dim", fitLine(location, timerText(), width)),
						theme.fg("dim", fitLine(stats.join(" "), model, width)),
					];
				},
			};
		});
	});

	pi.on("before_agent_start", () => {
		// Steering and follow-up messages remain part of the same timed task.
		if (startedAt !== undefined) return;

		startedAt = performance.now();
		lastElapsed = undefined;
		requestRender?.();
		interval = setInterval(() => requestRender?.(), 1000);
	});

	pi.on("agent_settled", () => {
		if (startedAt === undefined) return;

		lastElapsed = performance.now() - startedAt;
		startedAt = undefined;
		stopInterval();
		requestRender?.();
	});

	pi.on("session_shutdown", () => {
		stopInterval();
		startedAt = undefined;
		requestRender = undefined;
	});
}

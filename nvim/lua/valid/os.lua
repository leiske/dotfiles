-- An unfortunate assumption is that if we are using bash it means we are running WSL with the Windows Terminal.
-- Work computer will be zsh or fish and using iterm2
--
-- This is used to conditionally make keybinds dedicated to the terminal
-- emulator while trying to maintain consistency
IS_BASH = os.getenv("SHELL") == "/bin/bash"
print("IS_BASH: ", IS_BASH, ", TERM: ", os.getenv("TERM"))


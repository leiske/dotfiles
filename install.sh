ln -s $PWD/bash/.shared_profile ~/.shared_profile

if [ "$1" == "--work" ]; then
    ln -s $PWD/bash/.work_profile ~/.work_profile
else
    ln -s $PWD/bash/.home_profile ~/.home_profile
fi

#!/usr/bin/env bash

cd $DOOTS

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

# what directories should be installable by all users including the root user
base=(
    #bash
)

# folders that should, or only need to be installed for a local user
useronly=(
    config
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    stow --simulate --verbose --restow --target "${usr}" "${app}"
}

echo ""
echo "Stowing apps for user: $(whoami)"

# install apps available to local users and root
for app in "${base[@]}"; do
    stowit "${XDG_CONFIG_HOME}/" "$app" 
done

if [[ ! "$(whoami)" = *"root"* ]]; then
    for app in "${useronly[@]}"; do
        stowit "${XDG_CONFIG_HOME}/" "$app" 
    done;
fi

echo ""
echo "##### ALL DONE"

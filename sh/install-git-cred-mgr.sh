#!/usr/bin/en sh
# Install and (globally) configure Microsoft git credential manager
# https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage
# https://aka.ms/gcm -> https://github.com/GitCredentialManager/ \
#   git-credential-manager
# https://github.com/GitCredentialManager/git-credential-manager/ \
#   releases/tag/latest
# install script provided by Microsoft
# https://github.com/GitCredentialManager/git-credential-manager \
#   option-2-install-from-source-helper-script
# uninstall
# git-credential-manager-core unconfigure
# rm $(command -v git-credential-manager-core)

# pre
link="https://github.com/GitCredentialManager/git-credential-manager/releases"
latest_link="${link}/latest"
tar_repl="${link}/download/_#_/gcm-linux_amd64._%_.tar.gz"
header_tag="location: "
target_dir="${HOME}/Downloads"

# get current file
location=$(curl -sI $latest_link | sed -En "s/^${header_tag}(.*)/\1/p")
IFS='/' read -ra loc_arr <<< $location
latest=$(echo ${loc_arr[-1]} | tr -d "\r")
tar_latest=${tar_repl/_#_/${latest}}
tar_latest=${tar_latest/_%_/${latest/v/}}
IFS='/' read -ra tar_arr <<< $tar_latest
target_file="${target_dir}/${tar_arr[-1]}"
curl -o $target_file -LO $tar_latest

# install
tar -xvf $target_file -C /usr/local/bin
git-credential-manager-core configure

# config
git config --global credential.credentialStore secretservice

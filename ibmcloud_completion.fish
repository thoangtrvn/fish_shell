# Fish shell completions for ibmcloud, the package management system
# https://ibmcloud.io/docs
# Based on `ibmcloud help` as per version 4.4.11
# Advanced completions:
# - completion of already defined keys for `ibmcloud config`
# - completion of already created environment where possible
#
# Note: ibmcloud ships with a completion for fish, automatically generated
# from `ibmcloud -h` but it is far cruder than the completions in this file,
# and it is by nature far too tricky to tweak to get the desired richness.
# Hence this effort.

# First, as part of ibmcloud's configuration, some complete would have been defined
# Let's erase them, so that we start from a blank state
complete -c ibmcloud -e

# Complete using -n to select the given ibmcloud subcommand
# and passing the rest of the arguments to `complete`
# The goal here is to reduce clutter in the definitions below
function __fish_ibmcloud -a cmd
    complete -c ibmcloud -n "__fish_seen_subcommand_from $cmd" $argv[2..-1]
end

# Complete for the first argument only
function __fish_ibmcloud_top
    complete -c ibmcloud -n "test (count (commandline -opc)) -eq 1" $argv
end

function __fish_ibmcloud_config_keys
    ibmcloud config --show | string match -r '^\w+(?=:)'
end

function __fish_ibmcloud_environments
    ibmcloud env list | string match -rv '^#' | string match -r '^\S+'
end

# common options
complete -c ibmcloud -f
complete -c ibmcloud -s h -l help -d "Show help and exit"

# top-level options
__fish_ibmcloud_top -s V -l version -d "Show the ibmcloud version number and exit"

# top-level commands
#__fish_ibmcloud_top -a clean -d "Remove unused packages and caches"
#__fish_ibmcloud_top -a config -d "Modify configuration values in .ibmcloudrc"
#__fish_ibmcloud_top -a create -d "Create a new ibmcloud environment from a list of specified packages"
__fish_ibmcloud_top -a help -d "Displays a list of available ibmcloud commands and their help strings"
#__fish_ibmcloud_top -a info -d "Display information about current ibmcloud install"
#__fish_ibmcloud_top -a install -d "Installs a list of packages into a specified ibmcloud environment"
#__fish_ibmcloud_top -a list -d "List linked packages in a ibmcloud environment"
#__fish_ibmcloud_top -a package -d "Low-level ibmcloud package utility (EXPERIMENTAL)"
#__fish_ibmcloud_top -a remove -d "Remove a list of packages from a specified ibmcloud environment"
#__fish_ibmcloud_top -a uninstall -d "Alias for ibmcloud remove"
#__fish_ibmcloud_top -a search -d "Search for packages and display associated information"
#__fish_ibmcloud_top -a update -d "Updates ibmcloud packages to the latest compatible version"
#__fish_ibmcloud_top -a upgrade -d "Alias for ibmcloud update"
__fish_ibmcloud_top -a   api                                   -d "Set or view target API endpoint"
__fish_ibmcloud_top -a   login                                 -d "Log user in"
__fish_ibmcloud_top -a   target                                -d "Set or view the targeted region, account, resource group, org or space"
__fish_ibmcloud_top -a   config                                -d "Write default values to the config"
__fish_ibmcloud_top -a   update                                -d "Update CLI to the latest version"
__fish_ibmcloud_top -a   logout                                -d "Log user out"
__fish_ibmcloud_top -a   regions                               -d "List all the regions"
__fish_ibmcloud_top -a   version                               -d "Print the version"
__fish_ibmcloud_top -a   resource                              -d "Manage resource groups and resources"
__fish_ibmcloud_top -a   iam                                   -d "Manage identities and access to resources"
__fish_ibmcloud_top -a   dev                                   -d "Create, develop, deploy, and monitor applications"
__fish_ibmcloud_top -a   app                                   -d "[Deprecated] Manage Cloud Foundry applications and application related domains and routes."
__fish_ibmcloud_top -a   service                               -d "[Deprecated] Manage Cloud Foundry services."
__fish_ibmcloud_top -a   billing                               -d "Retrieve usage and billing information"
__fish_ibmcloud_top -a   plugin                                -d "Manage plug-ins and plug-in repositories"
__fish_ibmcloud_top -a   cf                                    -d "Run Cloud Foundry CLI with IBM Cloud CLI context"
__fish_ibmcloud_top -a   catalog                               -d "Manage catalog"
__fish_ibmcloud_top -a   account                               -d "Manage accounts, users, orgs and spaces"
__fish_ibmcloud_top -a   enterprise                            -d "Manage enterprise, account groups and accounts."
__fish_ibmcloud_top -a   cfee                                  -d "[Deprecated] Manage Cloud Foundry Enterprise Environments"
__fish_ibmcloud_top -a   cloud-functions                       -d "Manage Cloud Functions"
__fish_ibmcloud_top -a   wsk                                   -d "Manage Cloud Functions"
__fish_ibmcloud_top -a   functions                             -d "Manage Cloud Functions"
__fish_ibmcloud_top -a   fn                                    -d "Manage Cloud Functions"
__fish_ibmcloud_top -a   cos                                   -d "Interact with IBM Cloud Object Storage services"
__fish_ibmcloud_top -a   cr                                    -d "Manage IBM Cloud Container Registry content and configuration."
__fish_ibmcloud_top -a   cs                                    -d "Manage IBM Cloud Kubernetes Service clusters."
__fish_ibmcloud_top -a   ks                                    -d "Manage IBM Cloud Kubernetes Service clusters."
__fish_ibmcloud_top -a   oc                                    -d "Manage IBM Cloud Kubernetes Service clusters."
__fish_ibmcloud_top -a   ml                                    -d "Manage machine learning lifecycle on IBM Cloud"
__fish_ibmcloud_top -a   sdk                                   -d "An IBM Cloud command line plugin to generate an SDK from an OpenAPI specification document or to validate an OpenAPI spec"
__fish_ibmcloud_top -a   sl                                    -d "Manage Classic infrastructure services"


# command added by sourcing ~/miniibmcloud3/etc/fish/conf.d/ibmcloud.fish,
# which is the recommended way to use ibmcloud with fish
#__fish_ibmcloud_top -a activate -d "Activate the given environment"
#__fish_ibmcloud activate -x -a "(__fish_ibmcloud_environments)"
#__fish_ibmcloud_top -a deactivate -d "Deactivate current environment, reactivating the previous one"

# common to all top-level commands

#set -l __fish_ibmcloud_commands clean config create help info install list package remove uninstall search update upgrade
set -l __fish_ibmcloud_commands api login target config update logout regions version resource iam dev app service billing plugin cf catalog account enterprise cfee cloud-functions wsk functions fn cos cr cs ks oc ml sdk sl 

for cmd in $__fish_ibmcloud_commands
  #__fish_ibmcloud $cmd -l json -d "Report all output as json"
  #  __fish_ibmcloud $cmd -l debug -d "Show debug output"
    __fish_ibmcloud $cmd -l verbose -s v -d "Use once for info, twice for debug, three times for trace"
end

# 'clean' command
__fish_ibmcloud clean -s y -l yes -d "Do not ask for confirmation"
__fish_ibmcloud clean -l dry-run -d "Only display what would have been done"
__fish_ibmcloud clean -s q -l quiet -d "Do not display progress bar"
__fish_ibmcloud clean -s a -l all -d "Remove all: same as -iltps"
__fish_ibmcloud clean -s i -l index-cache -d "Remove index cache"
__fish_ibmcloud clean -s l -l lock -d "Remove all ibmcloud lock files"
__fish_ibmcloud clean -s t -l tarballs -d "Remove cached package tarballs"
__fish_ibmcloud clean -s p -l packages -d "Remove unused cached packages (no check for symlinks)"
__fish_ibmcloud clean -s s -l source-cache -d "Remove files from the source cache of ibmcloud build"

# 'config' command

__fish_ibmcloud config -l system -d "Write to the system .ibmcloudrc file"
__fish_ibmcloud config -l env -d "Write to the active ibmcloud environment .ibmcloudrc file"
__fish_ibmcloud config -l file -d "Write to the given file"
__fish_ibmcloud config -l show -x -a "(__fish_ibmcloud_config_keys)" -d "Display configuration values"
__fish_ibmcloud config -l show-sources -d "Display all identified configuration sources"
__fish_ibmcloud config -l validate -d "Validate all configuration sources"
__fish_ibmcloud config -l describe -x -a "(__fish_ibmcloud_config_keys)" -d "Describe configuration parameters"
__fish_ibmcloud config -l write-default -d "Write the default configuration to a file"
__fish_ibmcloud config -l get -x -a "(__fish_ibmcloud_config_keys)" -d "Get a configuration value"
__fish_ibmcloud config -l append -d "Add one configuration value to the end of a list key"
__fish_ibmcloud config -l prepend -d "Add one configuration value to the beginning of a list key"
__fish_ibmcloud config -l add -d "Alias for --prepend"
__fish_ibmcloud config -l set -x -a "(__fish_ibmcloud_config_keys)" -d "Set a boolean or string key"
__fish_ibmcloud config -l remove -x -a "(__fish_ibmcloud_config_keys)" -d "Remove a configuration value from a list key"
__fish_ibmcloud config -l remove-key -x -a "(__fish_ibmcloud_config_keys)" -d "Remove a configuration key (and all its values)"
__fish_ibmcloud config -l stdin -d "Apply configuration given in yaml format from stdin"

# 'help' command
__fish_ibmcloud help -d "Displays a list of available ibmcloud commands and their help strings"
__fish_ibmcloud help -x -a "$__fish_ibmcloud_commands"

# 'info' command
__fish_ibmcloud info -l offline -d "Offline mode, don't connect to the Internet."
__fish_ibmcloud info -s a -l all -d "Show all information, (environments, license, and system information)"
__fish_ibmcloud info -s e -l envs -d "List all known ibmcloud environments"
__fish_ibmcloud info -s l -l license -d "Display information about the local ibmcloud licenses list"
__fish_ibmcloud info -s s -l system -d "List environment variables"
__fish_ibmcloud info -l base -d "Display base environment path"
__fish_ibmcloud info -l unsafe-channels -d "Display list of channels with tokens exposed"

# The remaining commands share many options, so the definitions are written the other way around:
# the outer loop is on the options

# Option channel
for cmd in create install remove search update
    __fish_ibmcloud $cmd -s c -l channel -d 'Additional channel to search for packages'
end

# Option channel-priority
for cmd in create install update
    __fish_ibmcloud $cmd -l channel-priority -d 'Channel priority takes precedence over package version'
end

# Option clobber
for cmd in create install update
    __fish_ibmcloud $cmd -l clobber -d 'Allow clobbering of overlapping file paths (no warnings)'
end

# Option clone
__fish_ibmcloud create -l clone -x -a "(__fish_ibmcloud_environments)" -d "Path to (or name of) existing local environment"

# Option copy
for cmd in create install update
    __fish_ibmcloud $cmd -l copy -d 'Install all packages using copies instead of hard- or soft-linking'
end

# Option download-only
for cmd in create install update
    __fish_ibmcloud $cmd -l download-only -d 'Solve an environment: populate caches but no linking/unlinking into prefix'
end

# Option dry-run
for cmd in create install remove update
    __fish_ibmcloud $cmd -l dry-run -d 'Only display what would have been done'
end

# Option file
for cmd in create install update
    __fish_ibmcloud $cmd -l file -d 'Read package versions from the given file'
end

# Option force
for cmd in create install remove update
    __fish_ibmcloud $cmd -l force -d 'Force install (even when package already installed)'
end

# Option insecure
for cmd in create install remove search update
    __fish_ibmcloud $cmd -l insecure -d 'Allow ibmcloud to perform "insecure" SSL connections and transfers'
end

# Option mkdir
for cmd in create install update
    __fish_ibmcloud $cmd -l mkdir -d 'Create the environment directory if necessary'
end

# Option name
__fish_ibmcloud create -s n -l name -d "Name of new environment"
for cmd in install list remove search update
    __fish_ibmcloud $cmd -s n -l name -x -a "(__fish_ibmcloud_environments)" -d "Name of existing environment"
end

# Option no-channel-priority
for cmd in create install update
    __fish_ibmcloud $cmd -l no-channel-priority -l no-channel-pri -l no-chan-pri -d 'Package version takes precedence over channel priority'
end

# Option no-default-packages
__fish_ibmcloud create -l no-default-packages -d 'Ignore create_default_packages in the .ibmcloudrc file'

# Option no-deps
for cmd in create install update
    __fish_ibmcloud $cmd -l no-deps -d 'Do not install, update, remove, or change dependencies'
end

# Option no-pin
for cmd in create install remove update
    __fish_ibmcloud $cmd -l no-pin -d 'Ignore pinned file'
end

# Option no-show-channel-urls
for cmd in create install list update
    __fish_ibmcloud $cmd -l no-show-channel-urls -d "Don't show channel urls"
end

# Option no-update-dependencies
for cmd in create install update
    __fish_ibmcloud $cmd -l no-update-dependencies -l no-update-deps -d "Don't update dependencies"
end

# Option offline
for cmd in create install remove search update
    __fish_ibmcloud $cmd -l offline -d "Offline mode, don't connect to the Internet"
end

# Option only-deps
for cmd in create install update
    __fish_ibmcloud $cmd -l only-deps -d "Only install dependencies"
end

# Option override-channels
for cmd in create install remove search update
    __fish_ibmcloud $cmd -l override-channels -d "Do not search default or .ibmcloudrc channels"
end

# Option prefix
for cmd in create install list remove search update
    __fish_ibmcloud $cmd -s p -l prefix -d "Full path to environment prefix"
end

# Option quiet
for cmd in create install remove update
    __fish_ibmcloud $cmd -s q -l quiet -d "Do not display progress bar"
end

# Option show-channel-urls
for cmd in create install list update
    __fish_ibmcloud $cmd -l show-channel-urls -d "Show channel urls"
end

# Option update-dependencies
for cmd in create install update
    __fish_ibmcloud $cmd -l update-dependencies -l update-deps -d "Update dependencies"
end

# Option use-index-cache
for cmd in create install remove search update
    __fish_ibmcloud $cmd -s C -l use-index-cache -d "Use cache of channel index files, even if it has expired"
end

# Option use-local
for cmd in create install remove search update
    __fish_ibmcloud $cmd -l use-local -d "Use locally built packages"
end

# Option yes
for cmd in create install remove update
    __fish_ibmcloud $cmd -s y -l yes -d "Do not ask for confirmation"
end

# Option revision
__fish_ibmcloud install -l revision -d "Revert to the specified REVISION"

# Option canonical
__fish_ibmcloud list -s c -l canonical -d "Output canonical names of packages only. Implies --no-pip"

# Option explicit
__fish_ibmcloud list -l explicit -d "List explicitly all installed ibmcloud with URL (output usable by ibmcloud create --file)"

# Option export
__fish_ibmcloud list -s e -l export -d "Output requirement string only (output usable by ibmcloud create --file)"

# Option full-name
__fish_ibmcloud list -s f -l full-name -d "Only search for full names, i.e., ^<regex>\$"

# Option md5
__fish_ibmcloud list -l md5 -d "Add MD5 hashsum when using --explicit"

# Option no-pip
__fish_ibmcloud list -s c -l canonical -d "Output canonical names of packages only. Implies --no-pip"

# Option revisions
__fish_ibmcloud list -s r -l revisions -d "List the revision history and exit"

# Option all
__fish_ibmcloud remove -l all -d "Remove all packages, i.e., the entire environment"
__fish_ibmcloud update -l all -d "Update all installed packages in the environment"

# Option features
__fish_ibmcloud remove -l features -d "Remove features (instead of packages)"

# Option info
__fish_ibmcloud search -s i -l info -d "Provide detailed information about each package"

# Option platform
set -l __fish_ibmcloud_platforms {osx,linux,win}-{32,64}
__fish_ibmcloud search -l platform -x -a "$__fish_ibmcloud_platforms" -d "Search the given platform"

# Option reverse-dependency
__fish_ibmcloud search -l reverse-dependency -d "Perform a reverse dependency search"


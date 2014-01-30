git-branch-blacklist
====================

Blacklist system for git branches.

## Client Side

### Requirements
* bash 4+
* ssh command
* Standard linux/unix tools such as cut
* Access to the git repo location via ssh


### Configuration
git-branch-blacklist has one optional configuration item: branch-blacklist-config.path-prefix. This item should be set if the path in the remote.origin.url does not start with a leading slash (/). If this needs to be set git-branch-blacklist will complain and explain how to set it properly.


### git-branch-blacklist
This is the client side tool which allows for adding, removing and listing blacklisted branches on the server. It works by executing git commands on the git server over ssh.

The following commands are accepted by git-branch-blacklist:

* list
* add
* remove


#### list
This command removes a branch to the blacklist. It returns a list of blacklisted items on success and complains on error. Success always returns 0. Note that if nothing has been blacklisted yet the list of blacklisted items will be empty.

Example:
```
$ git-branch-blacklist list
branch_that_is_blacklisted
another_blacklisted_branch
$
```

#### add
This command adds a branch to the blacklist. It is silent on success and complains on error. Success always returns 0.

**Note**: it is possible to a single branch multiple times. This will not cause a problem with the system and can be cleaned up by removing the branch from the blacklist (or editing the server config file by hand).

Example:
```
$ git-branch-blacklist add branch_to_blacklist
$
```

#### remove
This command removes a branch to the blacklist. It is silent on success and complains on error. Success always returns 0. If a branch has been added multiple times the remove command will remove **all** instances in the config file.


Example:
```
$ git-branch-blacklist remove branch_to_blacklist
$
```

## Server Side

### Requirements
* bash 4+
* ssh server
* git repositories
* git config
* Standard linux/unix tools such as cut


## git-branch-blacklist-install
This is a server side tool which tries to install the git pre-receive hook intelligently and adding the git config section readying the repository for the blacklist system.

**Note**: It's highly recommended to take a backup of the repo to be safe!

Example:
```
$ git-branch-blacklist-install /full/path/to/repo/
The hook has been installed at .git/hooks/pre-receive
Updating the configuration ...
Done
$ 
```

### Configuration
Server side configuration requires a section named branch-blacklist. This will be automatically created if you use the git-branch-blacklist-install tool. It stores a list of blacklisted branches.

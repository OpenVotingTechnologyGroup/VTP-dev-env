## General VoteTrackerPlus Information

This VoteTrackerPlus project repository holds the VoteTrackerPlus software development environment.

A few _meta_ notes on working with VoteTrackerPlus software:

This repo contains four git submodules that comprise a complete VTP election instance.  They are:

| Git Repository | Contents | Development Notes |
| --- | --- | --- |
| an ElectionData git repository tree | Contains the ElectionData - the definition of the election (address, contest, and tally information etc); all blank ballots; all Cast Vote Records (contest CVR's) and ballot receipts | See [VTP-mock-election.US.17](https://github.com/OpenVotingTechnologyGroup/VTP-mock-election.US.17) or [VTP-mock-election.sRCV.1](https://github.com/OpenVotingTechnologyGroup/VTP-mock-election.sRCV.1) as examples |
| [VTP-web-api](https://github.com/OpenVotingTechnologyGroup/VTP-web-api) | Contains the python FastAPI & uvicorn based web API | main branch has linear history with signed commits |
| [VTP-web-client](https://github.com/OpenVotingTechnologyGroup/VTP-web-client) | Contains the html/css/javascript client front end | main branch has linear history with signed commits |
| [VoteTrackerPlus](https://github.com/OpenVotingTechnologyGroup/VoteTrackerPlus) | Contains the python based backend | main branch has linear history with signed commits |

The point of this repo is basically to track work that spans multiple repos and in particular when a specific set of the VTP repos are in a working state, such as at the end of a milestone or significant cross repo effort.

If one is working primarily in just one repo, then this repo can more or less be ignored.

The three code repos (VTP-web-client, VTP-web-api, VoteTrackerPlus) follow normal GitHub software development practices - GitHub issues, pull requests (PRs), discussion lists, project pages.  All work is done on a branch, PR'ed, and squah merged.  The ElectionData repo (VTP-mock-election.US.17) only employs the main branch for actual changes while executing the election consumes branches.  Branches can be used for development in the ElectionData repo, but the current practice is to just create another ElectionData repo and if/when it is all good, just swap it in.

Regarding python, poetry is primarly used to manage python environments and as such there is a pyproject.toml file in the VTP-web-api and VoteTrackerPlus repos.  Each python repo has its own python environment; however, the VTP-web-api poetry environment is a superset of the VoteTrackerPlus poetry environment.

Regarding javascript, the javascript is entirely for the client side frontend and so the browser determines the version of javascript in play, etc.  Best practices are recommended for writing and testing the javascript, namely it needs to work on the Chrome, Mozilla, and WebKit engines.  It also needs to be usable on mobile and desktop devices.

All commits across all the repos need to be signed - see [Signing commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)

## How to clone the VTP repos, including the mock (test) repo:

```bash
# Clone this repo (a https example - can also use ssh directly):
$ git clone https://github.com/OpenVotingTechnologyGroup/VTP-dev-env.git

# Run the makefile there, which will pull this and the other repos of interest
# as git submodules.  The 'make init' commands wraps the git submodule
# command which leaves the submodules as detached HEADs.  The 'make
# checkout' switches the HEAD to the main branch.
$ cd VTP-dev-env
$ make init
$ BRANCH=main make checkout

# Using poetry perform a local install of VoteTracker+
$ cd VoteTrackerPlus
$ make poetry-build
$ poetry env activate

# To setup a mock demo election using this (ElectionData) repo:
$ cd ../VTP-mock-election.sRCV.1
$ setup-vtp-demo

# To run the uvicorn server and have it listen on the LAN for incomgin 
# connections, first exit the VoteTrackerPlus poetry environment,
# create a web-api poetry environment, and run the uvicorn server:
$ exit
$ cd ../VTP-web-api
$ make conjoin
$ poetry install
$ poetry env activate
$ make run HOST=0.0.0.0

# Leaving off the HOST specification will run the uvicorn server listening
# only on localhost.
```

Note - the above does not include running a VTP backend tabulation server - see the VoteTrackerPlus for more information regarding that level of demo/test operation.  A backend tabulation server is the server process responsible for merging cast CVR's to the git main branch, allowing for the eventual aggregation in the ElectionData repository of all the tabulation servers involved in the election.  Contest CVR's are initially commited on independent git branches by either the web-api or CLI.

## FYI - a few GitHub status/reference links:

[GitHub status](https://www.githubstatus.com/)

[GitHub public key fingerprints](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)

[GitHub meta endpoint](https://api.github.com/meta)

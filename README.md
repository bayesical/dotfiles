# Introduction

This is a repo which houses all the dotfiles (configuration files) which I use for my development environment.

Having this as a public repository allows me to do two things:

1. To be able to recreate my development environment with a few trivial commands
2. To allow others to take parts they like about my development environment or to be able to fully recreate it 

# Dependencies (Pre-requisite)

This repository is targetted solely on machines with a UNIX based operating system.

It is assumed that you have the following applications installed on your machine:

* ZSH- [Installing ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
* Oh My Posh-
    - [Installing Oh My Posh on Linux](https://ohmyposh.dev/docs/installation/linux)
    - [Installing Oh My Posh on MacOS](https://ohmyposh.dev/docs/installation/macos)
* Neovim- [Installing Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim/921fe8c40c34dd1f3fb35d5b48c484db1b8ae94b)
* tmux- [Installing tmux](https://github.com/tmux/tmux/wiki/Installing#installing-tmux)

This is more of a "soft" dependency, the logic within the configurations builds functionality around the existance of a `~/repos` directory which contains all the repositories that are of interest to an individual (this is especially the case for the contents of the `.zshrc` file).

To utilise this functionality, ensure this pattern is being followed, adding in any repositories you work on into the `~/repos` directory. One has the ability to dictate the directory structure to their likening (for example, you could have a `~/repos/work` directory for repositories related to work and `~/repos/sdk` directory for repositories which house SDKs).

# Getting started

1. Clone the repository to a location of your preference:
```sh
git clone https://github.com/bayesical/dotfiles.git
```

2. Navigate to the repository such that the working directory is the root of the repository:
```
cd dotfiles
```

3. Ensure the setup shell script (`setup.sh`) is executable:
```sh
chmod +x ./setup.sh
```

4. Run the setup shell script:
```
./setup.sh
```

5. Enjoy!

# Supplementary

If you wish to make any changes to the configuration, do so in the dotfiles repository itself. This is because the setup shell script will have created symlinks **to the files in this repository** at the locations where the applications looks for its configuration file.


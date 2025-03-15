# lib-bash – Bash Libraries ![GitHub Release](https://img.shields.io/github/v/release/mmichaelis/lib-bash?logo=semanticrelease&link=https%3A%2F%2Fgithub.com%2Fmmichaelis%2Flib-bash%2Freleases%2Flatest)

![GitHub License](https://img.shields.io/github/license/mmichaelis/lib-bash?logo=unlicense&logoColor=%23fff&color=blue&link=https%3A%2F%2Funlicense.org%2F)
![GitHub Pages](https://img.shields.io/github/deployments/mmichaelis/lib-bash/github-pages?logo=githubpages&logoColor=%23fff&label=pages&link=https%3A%2F%2Fmmichaelis.github.io%2Flib-bash%2F&link=https%3A%2F%2Fgithub.com%2Fmmichaelis%2Flib-bash%2Fdeployments%2Fgithub-pages)

![Lib-Bash Decorative Image](docs/img/LibBashGitHubSocialPreview.jpg)

A set of libraries to use from within your Bash scripts.

## Table of Contents

* [Library Usage Pattern](#library-usage-pattern)
* [Libraries](#libraries)
  * [lib_console](#lib_init)
  * [lib_init](#lib_init)
  * [lib_scriptinfo](#lib_scriptinfo)
* [Installation](#installation)

## Library Usage Pattern

All libraries are meant to embedded in a similar way. The following applies
best practices according to spellcheck:

```bash
MY_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${MY_PATH}")"
readonly MY_PATH
readonly SCRIPT_DIR
readonly LIB_BASH_DIR="${SCRIPT_DIR}/lib_bash"
source "${LIB_BASH_DIR}/lib_<name>.sh"
```

## Overview of Libraries

For details, visit [the GitHub Pages](https://mmichaelis.github.io/lib-bash/).

### lib_console

Utility functions for console output, similar to general logging requirements.
Also, containing a specialized `cat` command supporting colored output.

### lib_gnucompat

Utility functions and dynamically defined constants for scripts preferring
(or requiring) GNU compatible tooling. Meant especially for systems such as
MacOS, to prefer GNU-Tools like `coreutils` by preferring prefixed tools like
`gsed`, `gawk`.

### lib_init

Apply general recommended strictness settings for Bash scripts. Includes support
for `DEBUG` environment variable at two stages: `1` enables debug logging, while
`2` (or above) triggers script debugging.

### lib_scriptinfo

Functions to provide information about your script.

## Installation

![GitHub Downloads (all assets, latest release)](https://img.shields.io/github/downloads/mmichaelis/lib-bash/latest/total?color=%2311A&link=https%3A%2F%2Fgithub.com%2Fmmichaelis%2Flib-bash%2Freleases%2Flatest)

Find below two possible installation scenarios, assuming, that you want to use
this libraries from your own Git managed repository.

As an alternative, you may just download the archives containing the minimal
set of files.

### Git Submodules

```bash
git submodule add https://github.com/mmichaelis/lib-bash.git lib-bash
git submodule update --init --recursive
```

### Git Subtrees

```bash
# Add Subtree
git subtree add --prefix=lib-bash \
  https://github.com/mmichaelis/lib-bash.git main --squash
# Update Subtree
git subtree pull --prefix=lib-bash \
  https://github.com/mmichaelis/lib-bash.git main --squash
```

## GitHub Pages

### Build Locally

To build the GitHub Pages locally, follow these steps:

```bash
cd docs
bundle install
bundle exec jekyll serve --source ./ --destination ../_site
```

Regarding supported plugins, see:

* [Dependency versions | GitHub Pages](https://pages.github.com/versions/)

## Kudos

This would not exist without help, including GitHub Copilot.

Other tools and applications, that helped me:

* [Favicon Generator - Text to Favicon - favicon.io](https://favicon.io/favicon-generator/)

  Used to generate first sketch of the `favicon.ico`. For reproducibility, here
  are the chosen configuration options:

* [Favicon Generator: Create Custom Icons from Text | Favicon Maker](https://www.favicongenerator.io/)

* [realfavicongenerator.net: Favicon Generator for perfect icons on all browsers](https://realfavicongenerator.net/)

  After recreating above sketches, adapted SVG directly and created favicon
  configuration using the _RealFaviconGenerator_.

* [Shields.io](https://shields.io/)

  Used to generate badges.

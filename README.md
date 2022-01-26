# git-continue

`git-continue` is a plug-in command for Git. After a continuable operation has
halted, `git-continue` determines the appropriate command with which to resume
and issues the `--continue` option.

`git-continue` can be invoked as `git-abort`, in which case it will instead
issue the `--abort` option.

`git-continue` supports the following operations:

- `git-am`
- `git-cherry-pick`
- `git-merge`
- `git-rebase`
- `git-revert`

**Table of Contents**

* [Usage](#usage)
* [Installation](#installation)
* [License](#license)

## Usage

**Synopsis:**

    git continue
    git abort

`git-continue` takes no options. If it doesn't recognize the current repository
state, it produces an error.

## Installation

Place `git-continue` somewhere in your `$PATH` as `git-continue`, `git-abort`,
or both. Git will automatically detect the executables as commands and provide
them as `git continue` respectively `git abort`. You can do this with `make
install`, optionally providing `PREFIX=<path>` to override the default
installation prefix of `$HOME/.local`.

## License

Copyright &copy; 2022 Mikkel Kjeldsen

This software is released under the GPLv2, on account of using components from
the Git project v2.25.0 released under the GPLv2 [[git-license]].

[git-license]: https://git.kernel.org/pub/scm/git/git.git/ "Official Git project repository"

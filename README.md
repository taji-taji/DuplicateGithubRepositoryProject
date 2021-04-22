# DuplicateGithubRepositoryProject

This command duplicates a GitHub repository project, **including its cards**.

## Installation

### Homebrew

```sh
$ brew tap taji-taji/duplicate-github-project
$ brew install duplicate-github-project
```

### From Source

```sh
$ git clone https://github.com/taji-taji/DuplicateGithubRepositoryProject.git
$ make install
```

## Usage

```sh
$ duplicate-github-project --github_access_token xxxxxxx --new_project_name NewProjectName --source_project_number 1 --owner RepositoryOwnerName -repository_name RepositoryName
```

You can use the environment variable `GITHUB_TOKEN` instead of the `--github_access_token` option.

```sh
$ GITHUB_TOKEN=xxxxxx duplicate-github-project --new_project_name NewProjectName --source_project_number 1 --owner RepositoryOwnerName -repository_name RepositoryName
```

The `--help` option outputs help.

```sh
$ duplicate-github-project --help


Usage: duplicate-github-project [--github_access_token,-t] [--new_project_name,-n] [--source_project_number,-s] [--owner,-o] [--repository_name,-r] 

This command duplicates a GitHub repository project, including its cards.

Options:
    github_access_token GitHub Access Token
       new_project_name Name for duplicated project
  source_project_number Project number for source project
                  owner Owner name for project
        repository_name Repository name for project
```

## Note

- Only Repository Project is supported.
  - Organization Project and User Project are not supported.

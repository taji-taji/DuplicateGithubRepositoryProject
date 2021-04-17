# GitHubRepositoryProjectsTemplate

## About

- GitHub のリポジトリ Project とその Project 内の「カラム」と「カード」と「Automation設定」を複製するスクリプトです
- プロジェクトのテンプレートを用意し GitHub の GUI 上から複製した場合、コピーされるのは「カラム」と「Automation設定」のみで、カードはコピーされません
- このスクリプトを利用することで「カード」も複製することが出来ます

## Usage

```sh
./duplicateGitHubProject -s 12345 -o taji-taji -r YourRepositoryName -t xxxxxxxx -n NewProjectName
```

### Options

- `-s` (**s**ource project number): 複製元のプロジェクトの番号 (プロジェクトの URL の末尾の数字)
- `-o` (**o**wner name): オーナー名
- `-r` (**r**epository name): リポジトリ名
- `-t` (github access **t**oken): GitHub アクセストークン
- `-n` (**n**ew project name): 新しく作成するプロジェクト名
- `-h`(**h**elp): ヘルプ

## Required

- curl
- jq

## Note

- リポジトリ Project のみ対応です
  - Organization Project や User Project には対応していません

# GitHubRepositoryProjectsTemplate

## About

- GitHub のリポジトリ Project とその Project 内の「カラム」と「カード」を複製するスクリプトです
- プロジェクトのテンプレートを用意し GitHub の GUI 上から複製した場合、コピーされるのは「カラム」と「Automation設定」のみで、カードはコピーされません
- このスクリプトを利用することで「カード」も複製することが出来ます

## Usage

```sh
./duplicateGitHubProject -s 12345 -o taji-taji -r YourRepositoryName -t xxxxxxxx -n NewProjectName
```

## Note

- Automation の設定はコピーされません
- リポジトリ Project のみ対応です
  - Organization Project や User Project には対応していません

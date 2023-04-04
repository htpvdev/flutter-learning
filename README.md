# Flutter 学習まとめ

- Flutterとは、スマホアプリ(iOS/Android)を作るためのフレームワーク。言語はDart。
- Flutterでアプリ開発をするためには、Flutter SDKというプログラムをインストールする必要がある。

## 環境構築

- プロジェクトごとにFlutter SDKのバージョンを管理したいので、そのままFlutter SDKをインストールはしない。
- FVM(Flutter Version Management)というアプリをインストールして、それを通してFlutter SDKをインストール・利用する。  
**※注意: fvmをインストールして使う場合、flutterコマンドは、「fvm flutter」コマンドに置き換わる。**  
**(例: `flutter --version`コマンドは使えず、`fvm flutter --version`とすることで使える。)**

### 環境構築 - Windows編

- 全体の流れとしては、flutterと無関係のChocolateyというコマンドラインツールをインストールして、その機能を使いFVMをインストールする。
(FVMと、Flutter SDKにはDart SDKが必要なので一緒にインストールされる)

1. Chocolateyのインストール
  - [公式サイト](https://chocolatey.org/install#individual)の手順に沿って行う。
  - PowerShellを管理者権限で起動し、以下のコマンドを実行
  - `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`
2. FVMのインストール
  - PowerShellを管理者権限で起動し、以下のコマンドを実行
  - `choco install fvm`
  - (コマンド実行中に入力を何度か求められるので、全て「yes」と入力)

### 環境構築 - Mac編

- ネット上にソースが多く、homebrewでポチるだけで簡単なので割愛。

### 環境構築 - VSCode - プロジェクト作成

- FVMをインストールしても、すぐにflutterコマンドが使えるようにはならない。flutterのバージョンを指定する必要がある。  
flutterのバージョンはプロジェクトごとに管理するため、まずはプロジェクトを作ろう。

- 


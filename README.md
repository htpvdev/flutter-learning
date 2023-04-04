# Flutter 学習まとめ

- Flutterとは、スマホアプリ(iOS/Android)を作るためのフレームワーク。言語はDart。
- Flutterでアプリ開発をするためには、Flutter SDKというプログラムをインストールする必要がある。

## 環境構築

- プロジェクトごとにFlutter SDKのバージョンを管理したいので、そのままFlutter SDKをインストールはしない。
- FVM(Flutter Version Management)というアプリをインストールして、それを通してFlutter SDKをインストール・利用する。  
**※注意: fvmをインストールして使う場合、flutterコマンドは、「fvm flutter」コマンドに置き換わる。**  
**(例: `flutter --version`コマンドは使えず、`fvm flutter --version`とすることで使える。)**
- また、PC上でスマホアプリの動作確認を行うために、スマートフォンをPC上で起動するアプリ(エミュレータ)もインストールする。

### 環境構築 Windows編

- 全体の流れとしては、flutterと無関係のChocolateyというコマンドラインツールをインストールして、その機能を使いFVMをインストールする。
(FVMと、Flutter SDKにはDart SDKが必要なので一緒にインストールされる)

1. Chocolateyのインストール
  - [公式サイト](https://chocolatey.org/install#individual)の手順に沿って行う。
  - PowerShellを管理者権限で起動し、以下のコマンドを実行  
  `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`
2. FVMのインストール
  - PowerShellを管理者権限で起動し、以下のコマンドを実行  
  `choco install fvm`
  - (コマンド実行中に入力を何度か求められるので、全て「yes」と入力)
3. Android

### 環境構築 Mac編

1. FVMのインストール
  - 以下のコマンドを実行する。homebrewが未インストールであればインストールしてから行う。  
  `brew tap leoafarias/fvm`  
  `brew install fvm`  


### 環境構築 VSCode - プロジェクト作成

- FVMをインストールしても、すぐにflutterコマンドが使えるようにはならない。flutterのバージョンを指定する必要がある。  
flutterのバージョンはプロジェクトごとに管理するため、まずはプロジェクトを作ろう。

- 空のフォルダを作ったら、そのフォルダをワークスペースとして開く。そのフォルダに、`.vscode`というディレクトリを作成し、`settings.json`を作成する。ファイルの内容は、このプロジェクトの`settings.json`をそのままコピペすればよし。

- プロジェクトがgitのリポジトリであるなら、トップレベルに`.gitignore`ファイルを作成する。内容はコピペする。

- 使用するFlutter SDKのバージョンを指定する。普通は、最新の安定板(Stable)を選択すればよい。
  - `fvm releases`コマンドを実行し、最新のリリース情報を取得する。最後の方に、stableと出てるバージョンが出るので、それを指定する。
  - すでにfvmを使わずFlutter SDKのプロジェクトを作成していた場合、`fvm use <バージョン名>`とすることで、このプロジェクト内で使うFlutter SDKのバージョンを指定できる。  
  例: `fvm use 3.7.9`とすれば、バージョン3.7.9のFlutter SDKがこのプロジェクト用に設定される。
  - もしくは、`fvm use stable`としても良い。この場合、最新の安定版がプロジェクトに設定される。

  - 完全に新規のプロジェクトである場合は、末尾に`-- force`とつける。  
  例: `fvm use stable --force` (安定版を設定する方法)

    - 指定したバージョンのFlutter SDKが端末に一度もインストールされていない場合、以下のようなメッセージが出るが、「Y」を押下する。  
    ```
    Flutter "stable" is not installed.
    Would you like to install it? Y/n:
    ```

  - ちなみに、オプションで`global`をつければ、プロジェクト外のディレクトリでも指定したバージョンでflutterコマンドが使えるようになるが、各プロジェクト外で使うシーンがないためあまり意味はない(`fvm use global 3.7.9`)。

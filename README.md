# singularity-apache2-igvwebapp
igv-webappとapache2を実行するsingularity instanceを起動するためのファイル一式です。
singularity imageは初回起動時にSylabs Cloudからダウンロードします。

## 初期設定
### httpd.conf

    ServerRoot "/usr/local/apache2"
    
    Listen 38080
    User user1
    Group group1

user1を自分のアカウント名、group1を自分のグループ名、38080をapache2が使用するポート番号に修正します。
netstatコマンドで38080が未使用なら変更不要です。

### package.json

    {
      "name": "igv-webapp",
      "version": "1.2.8",
      "description": "igv web app",
      "keywords": [],
      "author": "Douglass Turner and Jim Robinson",
      "license": "MIT",
      "scripts": {
        "start": "http-server -p 38081 dist",

38081をigv-webappが使用するポート番号に修正します。
netstatコマンドで38081が未使用なら変更不要です。

## singularity instanceの起動

    $ bash start_container.sh

初回実行時に、ubuntu-18.04-apache-2.4.38-igv-webapp-1.2.8_latest.sif がダウンロードされます。
また、cgi-bin, htdocs, logsディレクトリが作成されます。
htdocsディレクトリに、igv-webappで表示したいbamファイルとインデックスファイルを配置してください。

## igv-webappへのアクセス

ウェブブラウザで http://<ホストのIPアドレス>:<package.jsonに設定したポート番号> にアクセスしてください。
トラックの追加は、TracksメニューからURLを選び、

* http://<ホストのIDアドレス>:<httpd.confに設定したポート番号>/<htdocsに配置したbamファイル>
* http://<ホストのIDアドレス>:<httpd.confに設定したポート番号>/<htdocsに配置したインデックスファイル>

を開いてください。

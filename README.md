# Dockerを使ったsagemath環境の構築

このページでは、Vagrantで構築した環境と同じものをDockerで構築するための
方法を紹介します。

## Dockerfile
Dockerfileは、以下のサイトを参考にしました。

- https://github.com/sagemath/docker

### dockerの実行
キャラクターベースでsageを使用する場合には、以下のコマンドを実行します。
```bash
$ docker run -i -t take-pwave/sagemath
```

jupyterのノートブックを使用する場合には、以下のコマンドを実行します。

```bash
$ docker run -p 127.0.0.1:8888:8888 -d -t take-pwave/sagemath --notebook=ipython --ip='*' --port=8888
```

これで、ブラウザーで以下のURLを入力するとjupyterの画面になります。
```
http://localhost:8888/
```


## Dockerのインストール
以下のサイトからご使用の環境にあったDockerをダウンロードし、インストールしてください。

- Mac OSX: https://docs.docker.com/docker-for-mac/
- Windows 10: https://docs.docker.com/docker-for-windows/

CentOSの場合は、以下のコマンドでインストールできます。
```bash
$ sudo yum install docker
```

Ubuntuの場合には、以下のコマンドでインストールします。
```bash
$ sudo apt-get install docker.io
```

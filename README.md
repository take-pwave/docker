# Dockerを使ったsagemath環境の構築

このページでは、Vagrantで構築した環境と同じものをDockerで構築するための
方法を紹介します。

## Dockerfile
Dockerfileは、以下のサイトを参考にしました。

- https://github.com/sagemath/docker

### dockerの実行
キャラクターベースでsageを使用する場合には、以下のコマンドを実行します。
```bash
$ docker run -i -t takepwave/sagemath
```

jupyterのノートブックを使用する場合には、以下のコマンドを実行します。
(通常ならこれで起動するはずですが、ノートブックでsage kernelを起動すると落ちる障害が発生します)

```bash
$ docker run -p 127.0.0.1:8888:8888 -d -t takepwave/sagemath /opt/sage_launcher --notebook=ipython --ip='*' --port=8888
```

補足情報：
- https://github.com/ipython/ipython/issues/7062

暫定処置として、以下のように起動してください。
```bash
$ docker run -p 127.0.0.1:8888:8888 -d -t takepwave/sagemath /opt/sage_launcher -sh -c "ipython notebook --no-browser --ip='0.0.0.0' --port=8888"
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

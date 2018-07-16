# Dockerを使ったsagemath環境の構築

このページでは、
[Vagrantで構築したjupyterノートブック](https://github.com/take-pwave/notebook)
が動作する環境をDockerで構築するための方法を紹介します。

## 必要なパッケージ
インストールの必要なUbuntu用のパッケージは、以下の通りです。
- libmagickwand-dev: 画像の変換用
- jags: 階層ベイズ解析ツール
- gdal-bin: 地理データ変換ツール
- mecab, libmecab-dev, mecab-ipadic-utf8: 日本語形態素解析ツール
- build-essential cmake unzip: ビルドツール
- libopenblas-dev liblapack-dev: BLAS用
- libhdf5-serial-dev: HDF5用
- graphviz: kerasモデル描画用
- openscad: ScriptベースのCAD

python用のパッケージは、以下の通りです。
- pandas
- ggplot
- Wand
- seaborn
- pyjags
- sklearn
- xlsWriter xlrd xlwt
- python-nvd3
- mecab-python
- pydot-ng
- tensorflow
- keras
- numpy-stl
- wfdb
- pytorch
- torchvision
- doc2tex

Rでは、以下のパッケージをインストールしました。
- ggplot2
- jsonlite
- glmmML
- coda
- rjags
- car
- FNN
- MASS

## dockerの実行
キャラクターベースでsageを使用する場合には、以下のコマンドを実行します。
```bash
$ docker run -i -t takepwave/sagemath
```

jupyterのノートブックを使用する場合には、以下のコマンドを実行します。
(通常ならこれで起動するはずですが、ノートブックでsage kernelを起動すると落ちる障害が発生します)

```bash
$ docker run -p 127.0.0.1:8888:8888 -d -t takepwave/sagemath /opt/sage_launcher \
	--notebook=ipython --ip='*' --port=8888
```

補足情報：
- https://github.com/ipython/ipython/issues/7062

暫定処置として、以下のように起動してください。
```bash
$ docker run -p 127.0.0.1:8888:8888 -d -t takepwave/sagemath /opt/sage_launcher \
	-sh -c "ipython notebook --no-browser --ip='0.0.0.0' --port=8888"
```

これで、ブラウザーで以下のURLを入力するとjupyterの画面になります。
```
http://localhost:8888/
```

## ローカルディスクのノートブックを使う
dockerを起動しているマシンにあるノートブックをdockerのsage jupyterで使用するには、dockerの-vオプションを使用します。

```
-v ローカルのノートブックのパス:/home/sage/notebook
```

以下は、ローカルの$HOME/proj/jupyter/MySage/notebookを/home/sage/notebookにマウントした時の例です。

```bash
$ docker run -v $HOME/proj/jupyter/MySageMath/notebook/:/home/sage/notebook \
	-p 127.0.0.1:8888:8888 -d -t takepwave/sagemath /opt/sage_launcher \
	-sh -c "ipython notebook --no-browser --ip='0.0.0.0' --port=8888"
```

## コンテナーの操作
現在動いているコンテナーは、docker psコマンドで確認することができます。
-aのオプションを付けると停止しているコンテナーも知ることができます。

ここでキーとなるのは、sage_launcherのCONTAINER IDです。これを控えておいて次の操作をしてみましょう。

```bash
$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                      NAMES
4a704622db7a        takepwave/sagemath   "/opt/sage_launcher -"   45 minutes ago      Up 45 minutes       127.0.0.1:8888->8888/tcp   berserk_stonebraker
```

### dockerコンテナーの停止
実行中のコンテナーを停止するには、docker stopコマンドを使用します。

この時、先ほど控えたCONTAINER IDを使用します。

```bash
$ docker stop 4a704622db7a
4a704622db7a
```

### dockerコンテナー再開
停止したコンテナーを再開するには、docker startコマンドを使用します。

docker startの後にdocker ps -aで調べたCONTAINER IDを指定します。

```bash
$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                       PORTS               NAMES
4a704622db7a        takepwave/sagemath   "/opt/sage_launcher -"   55 minutes ago      Exited (137) 2 minutes ago 
$ docker start 4a704622db7a
4a704622db7a
```

このように一度起動したjupyter環境を簡単に停止、再開することができます。

## Dockerのインストール
以下のサイトからご使用の環境にあったDockerをダウンロードし、インストールしてください。

- Mac OSX: https://docs.docker.com/docker-for-mac/
- Windows 10: https://docs.docker.com/docker-for-windows/

CentOSの場合は、以下のコマンドでインストールできます。
```bash
$ sudo yum install docker
```

Ubuntuの場合には、以下のコマンドでインストールできます。
```bash
$ sudo apt-get install docker.io
```

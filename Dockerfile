# Sage Installation from Ubuntu PPA
#
# VERSION 0.2
FROM takepwave/primesage:latest
MAINTAINER Hiroshi TAKEMOTO <take.pwave@gmail.com>
USER root

RUN apt-get install -y libmagickwand-dev
RUN apt-get install -y jags 
RUN apt-get install -y gdal-bin

COPY installRpackages.R /opt/installRpackages.R

RUN apt-get install -y wget
RUN wget https://cran.r-project.org/src/contrib/Archive/rjags/rjags_3-15.tar.gz
RUN sage -R --save </opt/installRpackages.R

RUN sage -pip install pandas
RUN sage -pip install ggplot
RUN sage -pip install Wand
RUN sage -pip install seaborn
RUN sage -pip install pyjags
RUN sage -pip install sklearn
RUN sage -pip install xlsxWriter xlrd xlwt
RUN sage -pip install python-nvd3

RUN apt-get install -y mecab libmecab-dev mecab-ipadic-utf8
RUN sage -pip install mecab-python

USER sage
CMD ["/opt/sage_launcher"]

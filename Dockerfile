# Sage Installation from Ubuntu PPA
#
# VERSION 0.1
FROM ubuntu:14.04
MAINTAINER Hiroshi TAKEMOTO <take.pwave@gmail.com>

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:aims/sagemath
RUN apt-get update
RUN apt-get install -y libmagickwand-dev


RUN apt-get install -y jags pkg-config
RUN apt-get install -y gdal-bin
RUN apt-get install -y sagemath-upstream-binary-full

RUN sage -pip install pandas
RUN sage -pip install ggplot
RUN sage -pip install Wand
RUN sage -pip install seaborn
RUN sage -pip install pyjags
RUN sage -pip install sklearn
RUN sage -pip install xlsxWriter xlrd
RUN sage -pip install python-nvd3

COPY sitecustomize.py /usr/lib/sagemath/local/lib/python2.7/site-packages/
COPY sage_launcher /opt/sage_launcher
COPY installRpackages.R /opt/installRpackages.R

RUN apt-get install -y wget
RUN wget https://cran.r-project.org/src/contrib/Archive/rjags/rjags_3-15.tar.gz
RUN sage -R --save </opt/installRpackages.R

RUN useradd --comment "Sage Math" --user-group --groups users --create-home sage
RUN echo 'sage ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/sage

USER sage
EXPOSE 8888
CMD ["/opt/sage_launcher"]

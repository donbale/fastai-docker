# will be the most current version of the fastai library
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04 as base

LABEL maintainer="donbale | christopherbale@icloud.com"

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        curl \
        pkg-config \
        software-properties-common \
        unzip \
        vim \
        libjpeg-dev \
        libpng-dev \
        git \
        screen \
        htop \
        && rm -rf /var/lib/apt/lists/*


# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

# install python 3.7
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.7 \
    python3.7-distutils \
    python3.7-dev

RUN apt-get install wget
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.7 get-pip.py

RUN pip3.7 install -U pip
RUN pip3.7 install -U setuptools

# Some TF tools expect a "python" binary
RUN ln -s /usr/bin/python3.7 /usr/bin/python 
RUN ln -s /usr/bin/pip3.7 /usr/bin/pip 

# fastai

RUN pip install fastai>=0.0.11 \
	graphviz
	ipywidgets
	matplotlib
	nbdev>=0.2.12
	pandas
	scikit_learn
	azure-cognitiveservices-search-imagesearch
	sentencepiece

# Install jupyter notebook and set up our notebook config.
RUN pip install \
    jupyterlab \
    notebook \
    ipywidgets \
    jupyter_http_over_ws \
    jupyter_contrib_nbextensions	

RUN jupyter serverextension enable --py jupyter_http_over_ws

COPY jupyter_notebook_config.py /root/.jupyter/

EXPOSE 8888
EXPOSE 6006

RUN python -m ipykernel.kernelspec

WORKDIR /fastai

CMD ["bash", "-c", "jupyter notebook --allow-root --ip 0.0.0.0 --no-browser"]





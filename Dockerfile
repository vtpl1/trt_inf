#FROM nvcr.io/nvidia/tensorrt:19.10-py3
# ubuntu 18.04, cuda 10.1.243, cudnn 7, tensorrt 6.0.1
FROM nvcr.io/nvidia/tensorrt:20.03-py3
# ubuntu 18.04, cuda 10.2.89, cudnn 7.6.5, tensorrt 7.0.0

# FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04


RUN apt update --fix-missing && apt install -y --fix-missing
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 
RUN DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common
# RUN add-apt-repository -y ppa:jonathonf/ffmpeg-4
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y ffmpeg libavcodec-dev libavfilter-dev libavformat-dev libavutil-dev

RUN DEBIAN_FRONTEND=noninteractive apt install -y subversion git curl wget ninja-build build-essential gdb python3-tk python3-pip

#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends libxext6 libxrender1 libxtst6
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends libqt5x11extras5

# RUN apt -y remove x264 libx264-dev

# ## Install dependencies
# RUN apt -y install build-essential checkinstall cmake pkg-config yasm
# RUN apt -y install git gfortran
# RUN apt -y install libjpeg8-dev libpng-dev


# RUN apt -y install libjasper1
# RUN apt -y install libtiff-dev

# RUN apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
# RUN apt -y install libxine2-dev libv4l-dev
# RUN cd /usr/include/linux && ln -s -f ../libv4l1-videodev.h videodev.h

# RUN apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
# RUN apt -y install libgtk2.0-dev libtbb-dev qt5-default
# RUN apt -y install libatlas-base-dev
# RUN apt -y install libfaac-dev libmp3lame-dev libtheora-dev
# RUN apt -y install libvorbis-dev libxvidcore-dev
# RUN apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
# RUN apt -y install libavresample-dev
# RUN apt -y install x264 v4l-utils

# # Optional dependencies
# RUN apt -y install libprotobuf-dev protobuf-compiler
# RUN apt -y install libgoogle-glog-dev libgflags-dev
# RUN apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

RUN pip3 install yapf black cmake pytest pylint
ARG USERNAME=vadmin
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME
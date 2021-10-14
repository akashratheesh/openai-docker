## OPENAI GYM with Tensorflow GPU and VNC (for rendering) support

# Using Tensorflow GPU Base Image 
# Change to tensorflow/tensorflow:latest to change to CPU version

FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

LABEL maintainer="Akash Ratheesh <akash.ratheeshbabu@colorado.edu>"

ARG DEBIAN_FRONTEND=noninteractive

ARG install_jupyter

RUN apt-get update && \
    apt-get install -y \
        ffmpeg \
        libpq-dev \
        libjpeg-dev \
        libboost-all-dev \
        libsdl2-dev \
        libgl1-mesa-dev \
        libgl1-mesa-glx \
        libglew-dev \
        libosmesa6-dev \
        software-properties-common \
        net-tools \
        virtualenv \
        curl \
        cmake \
        vim \
        swig \
        wget \
        unzip \
        git \
        # For Virtual Display
        xvfb \
        # For VNC Support
        x11vnc \
        # Ratpoison- Window Manager
        ratpoison \   
        xterm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /root/.cache/pip/

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:deadsnakes/ppa && apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes  python3.6-dev python3.6 python3-pip python3-opengl python3-tk

RUN rm /usr/bin/python
RUN rm /usr/bin/python3
RUN rm /usr/bin/pip3
RUN ln -s /usr/bin/python3.6 /usr/bin/python
RUN ln -s /usr/bin/python3.6 /usr/bin/python3
RUN ln -s /usr/bin/pip3.6 /usr/bin/pip






RUN  python3 -m pip install futures==2.2.0 numpy==1.13.3 tensorflow-gpu==1.9

# Install Gym

RUN  python3 -m pip install gym==0.9.4

## Mujoco Setup


# Install MuJoCo

RUN mkdir -p /.mujoco \
    && wget https://www.roboti.us/download/mjpro131_linux.zip -O mujoco.zip \
    && unzip mujoco.zip -d /root/.mujoco \
    && rm mujoco.zip


# Add Mujoco License

COPY "mjkey.txt" "/root/.mujoco/"

# Add Mujoco Locations to path
ENV LD_LIBRARY_PATH /root/.mujoco/mjpro131/bin:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

ENV MUJOCO_PY_MJKEY_PATH="/root/.mujoco/mjkey.txt"
ENV MUJOCO_PY_MJPRO_PATH="/root/.mujoco/mjpro131"
RUN  python3 -m pip  install mujoco-py==0.5.7





# JupyterLab Port
EXPOSE 8000

# TensorBoard Port
EXPOSE 6006

# VNC Port
EXPOSE 5900


## Startup Scripts

# Set VNC Params

RUN mkdir ~/.vnc
RUN mkdir ~/.vnclogs

# Change VNC password here (Default password is 1234)
RUN x11vnc -storepasswd "1234" ~/.vnc/passwd




WORKDIR /

SHELL ["/bin/bash", "-lc"] 



# Change VNC Display Param here (Default Screen Size: 1024x768x24)

COPY "startup.sh" "/usr/lib/startup.sh"
COPY "startup_jupyter.sh" "/usr/lib/startup_jupyter.sh"


RUN if [[ -z "$install_jupyter" ]] ; \
        then echo "JupyterLab will not be installed." ; \
    elif [ "$install_jupyter" = "yes" ] ; \
        then echo "JupyterLab will be installed." && \
         python3 -m pip install  jupyterlab && \
        rm -rf /usr/lib/startup.sh &&  \
        mv /usr/lib/startup_jupyter.sh /usr/lib/startup.sh; \
    else echo "JupyterLab will not be installed."; \
    fi

RUN chmod +x "/usr/lib/startup.sh" 

RUN printf "#!/bin/bash \n/usr/bin/xvfb-run -n 100 -s \"-screen 0 1024x768x24 \" \"/usr/lib/startup.sh\"" >> /usr/lib/container_init.sh

RUN chmod +x "/usr/lib/container_init.sh"
ENTRYPOINT /usr/lib/container_init.sh

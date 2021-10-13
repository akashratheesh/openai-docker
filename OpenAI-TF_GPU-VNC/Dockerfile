## OPENAI GYM with Tensorflow GPU and VNC (for rendering) support

# Using Tensorflow GPU Base Image 
# Change to tensorflow/tensorflow:latest to change to CPU version

FROM tensorflow/tensorflow:latest-gpu

LABEL maintainer="Akash Ratheesh <akash.ratheeshbabu@colorado.edu>"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        ffmpeg \
        python3-opengl \
        python3-pip\
        python3-tk \
        libpq-dev \
        libjpeg-dev \
        libboost-all-dev \
        libsdl2-dev \
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


RUN /usr/bin/python3 -m pip install --upgrade pip

## Install OpenAI GYM (Build from Source)
## UNCOMMENT FROM HERE

# WORKDIR /opt
# RUN git clone https://github.com/openai/gym.git && pip install -e './gym'

## TILL HERE

## Install OpenAI GYM (COMMENT OUT Below Line if built from source)

RUN pip3 install gym pyglet


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

COPY "startup.sh" "/opt/startup.sh"
RUN chmod +x "/opt/startup.sh" 

WORKDIR /

SHELL ["/bin/bash", "-lc"] 



# Change VNC Display Param here (Default Screen Size: 1024x768x24)
RUN printf "#!/bin/bash \n/usr/bin/xvfb-run -n 100 -s \"-screen 0 1024x768x24 \" \"/opt/startup.sh\"" >> /opt/container_init.sh

RUN chmod +x "/opt/container_init.sh"
ENTRYPOINT /opt/container_init.sh

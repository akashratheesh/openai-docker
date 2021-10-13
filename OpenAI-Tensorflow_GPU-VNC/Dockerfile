## OPENAI GYM with Tensorflow GPU and VNC (for rendering) support

# Using Tensorflow GPU Base Image 
# Change to tensorflow/tensorflow:latest to change to CPU version

FROM tensorflow/tensorflow:latest-gpu

ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install -y \
        ffmpeg \
        python3-pyglet \
        python3-opengl \
        python3-pip\
        python3-tk \
        libpq-dev \
        libjpeg-dev \
        libboost-all-dev \
        libsdl2-dev \
        curl \
        cmake \
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


## Install OpenAI GYM (Build from Source)
## UNCOMMENT FROM HERE

# WORKDIR /opt
# RUN git clone https://github.com/openai/gym.git && pip install -e './gym'

## TILL HERE

## Install OpenAI GYM 

RUN pip3 install gym pyglet


# TensorBoard Port
EXPOSE 6006

# VNC Port

EXPOSE 6006


## Startup Scripts (Change VNC Display Param here or use -e while Docker run)

ENV OPENAI_DISPLAY_SIZE=1024x768x24

# Set VNC Params

mkdir ~/.vnc
mkdir ~/.vnclogs

# Change VNC password here
RUN x11vnc -storepassws "1234" ~/.vnc/passwd



COPY "startup.sh" "/opt/startup.sh"
RUN chmod +x "/opt/startup.sh" 

WORKDIR /
CMD ["/opt/container-start.sh"]


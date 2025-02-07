FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
LABEL authors="Ethan Porcaro"

# Requirements

RUN apt update && apt install -y git espeak-ng
RUN TZ=Etc/UTC DEBIAN_FRONTEND=noninteractive apt install -y tzdata

RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3.9-venv
RUN python3.9 -m ensurepip

# Set up repo

RUN git clone https://github.com/rhasspy/piper
WORKDIR piper/src/python
RUN python3.9 -m pip install -e .

RUN apt install -y gcc
RUN apt install -y python3.9-dev
RUN bash ./build_monotonic_align.sh

RUN python3.9 -m pip install "numpy<2" "torchmetrics==0.11.4"
RUN python3.9 -m pip install -U "huggingface_hub[cli]"

# Run
ENV HF_TOKEN=""
ENV HF_DATASET=""

ENV CHECKPOINT="en/en_US/lessac/high/epoch=2218-step=838782.ckpt"
ENV LANGUAGE="en-us"

ENV NUM_WORKERS=16

ENV ACCELERATOR="gpu"
ENV BATCH_SIZE=16
ENV MAX_EPOCHS=10000
ENV CHECKPOINT_EPOCHS=10
ENV QUALITY="high"

COPY start.sh .
CMD ["/bin/bash", "./start.sh"]
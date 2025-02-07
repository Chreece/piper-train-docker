FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime
LABEL authors="Ethan Porcaro"

# Requirements

RUN apt update && apt install -y git espeak-ng

# Set up repo

RUN git clone https://github.com/rhasspy/piper
WORKDIR piper/src/python

# See https://github.com/rhasspy/piper/issues/295#issuecomment-1839713379
COPY requirements.txt .
RUN pip install -e .

RUN apt install -y gcc
RUN bash ./build_monotonic_align.sh

RUN pip install tensorboard huggingface_hub[cli]

# Run
ENV HF_TOKEN=""
ENV HF_DATASET=""

ENV CHECKPOINT="en/en_US/lessac/high/epoch=2218-step=838782.ckpt"
ENV LANGUAGE="en-us"

ENV NUM_WORKERS=16

ENV ACCELERATOR="gpu"
ENV BATCH_SIZE=16
ENV MAX_EPOCHS=10000
ENV CHECKPOINT_EPOCHS=50
ENV QUALITY="high"

COPY start.sh .
CMD ["/bin/bash", "./start.sh"]
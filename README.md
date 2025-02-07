# piper-train-docker

Image for training a Piper TTS voice easily.

*This only supports single-gpu training currently.*

# Quickstart

See inside the Dockerfile for all environmental variables

## Generate dataset

See the dataset format [here](https://github.com/rhasspy/piper/blob/master/TRAINING.md#dataset-format).

**TL;DR:**

There is a `metadata.csv` at the root. It looks like this:

`id | text`

Where `id.wav` exists in the `wav` subfolder.

### With Hugging Face
You will need a Hugging Face token and a Repo id. They use the environmental variables `HF_TOKEN` and `HF_DATASET` respectively

### Without Hugging Face
You will need to mount your dataset folder to `/dataset` within the container

## Run training

### Base Checkpoint
By default, the base checkpoint is the high quality "lessac" voice. You can set the checkpoint with the `CHECKPOINT` variable

#### Using pretrained from Hugging Face
Use a file name from  [the checkpoint repo](https://huggingface.co/datasets/rhasspy/piper-checkpoints/tree/main)

For example: `en/en_US/lessac/high/epoch=2218-step=838782.ckpt`

#### Custom checkpoint
If you want to use a predefined checkpoint, you'll need to mount it in `/base_checkpoints` and set the `CHECKPOINT` variable to the checkpoint's filename

For example: `lessac.ckpt` (assuming `/base_checkpoints/lessac.ckpt` is mounted)

## Results

The files end up in the `/cache` directory. You should mount it if you want to persist the files.

Tensorboard will be started and running on port `6006`. You will need to forward it if you want to use the interface

# Example command

(See 'Generate Dataset' section first)

## With Hugging Face dataset

```shell
docker run --gpus all -p 6006:6006 -e HF_TOKEN=... -e HF_DATASET=... -e CUDA_VISIBLE_DEVICES=0 -v ./cache:/cache ifansnek/piper-train-docker:latest
```

## With local dataset

```shell
docker run --gpus all -p 6006:6006 -e CUDA_VISIBLE_DEVICES=0 -v ./dataset/dataset -v ./cache:/cache ifansnek/piper-train-docker:latest
```

**Note:**

Sometimes in WSL you will need to use something like `--gpus all --shm-size 32 --ipc=host` for proper CUDA use if you run out of shared memory.

Additionally, you may have to use absolute bind mount paths on Windows.
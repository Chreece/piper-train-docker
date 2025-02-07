# piper-train-docker

Image for training a Piper TTS voice from a Hugging Face dataset.

# Quickstart

See inside the Dockerfile for all environmental variables

## Generate dataset

See the dataset format [here](https://github.com/rhasspy/piper/blob/master/TRAINING.md#dataset-format).

**TL;DR:**

There is a `metadata.csv` at the root. It looks like this:

`id | utterance`

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

if [[ ! -z ${HF_TOKEN} ]]; then
  huggingface-cli login --token ${HF_TOKEN}
fi
if [[ ! -z ${HF_DATASET} ]]; then
  huggingface-cli download ${HF_DATASET} --local-dir /dataset --repo-type dataset
fi

huggingface-cli download rhasspy/piper-checkpoints ${CHECKPOINT} --local-dir /base_checkpoints --repo-type dataset

python3 -m piper_train.preprocess \
--language ${LANGUAGE} \
--input-dir /dataset \
--output-dir /cache \
--dataset-format ljspeech \
--single-speaker \
--sample-rate 22050 \
--max-workers ${NUM_WORKERS}

python3 -m piper_train \
--dataset-dir /cache \
--resume_from_checkpoint /base_checkpoints/${CHECKPOINT} \
--accelerator ${ACCELERATOR} \
--batch-size ${BATCH_SIZE} \
--max_epochs ${MAX_EPOCHS} \
--checkpoint-epochs ${CHECKPOINT_EPOCHS} \
--quality ${QUALITY} \
--validation-split 0.0 \
--num-test-examples 0 \
--precision 16 \
& tensorboard --logdir /cache/lightning_logs --bind_all
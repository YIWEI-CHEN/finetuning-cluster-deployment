# Multi-node GPU Cluster Deployment
[Open R1](https://github.com/huggingface/open-r1) has example scripts for fine-tuning Qwen2.5 models on multiple GPUs. Its libraries rely on CUDA 12.4, while the default CUDA version in AzureML Compute Instances is 12.2. In the repo, we provide step-by-step scripts to upgrade CUDA to 12.4 and install `openr1` virtual environment on AML Compute Instances. After the upgrade, you can follow the Supervised Fine-Tuning (SFT) and Reinforcement Fine-Tuning (RFT) instructions in [Open-R1](https://github.com/huggingface/open-r1) to fine-tune your models.

## 📝 To-Do List
- [ ] Python Script to create a new AzureML Compute Instance with GPU
- [ ] Shell Script to upload SSH key to the Compute Instance

# xojo-llama
A wrapper module to do local LLM inference with GGUF models using the llama.cpp binaries.

## Installation

1. Clone the xojo-llama repository on your local machine.
2. Create a bin/ folder next to the src/ folder.
3. Download the latest Llama binaries relevent for your machine architecture from https://github.com/ggml-org/llama.cpp/releases and extract the content to the new bin folder.
4. Delete the current CopyLlamaBinaries build step for your platform, and replace it with a new one that copies all the files in the bin/ folder (for debug and release).
5. You should now be able to do inference on any GGUF model that your hardware is capable of running.

## Support the Project

[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.com/donate/?business=accounts@zoclee.com&no_recurring=0&currency_code=USD)

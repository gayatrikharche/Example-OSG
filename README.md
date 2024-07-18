# **Method 1: Small Dataset (150 MB) - CIFAR-10**

## **Overview**

This document describes the process for using Method 1 to train a PyTorch model on the CIFAR-10 dataset, a popular dataset for image classification tasks. The process involves data acquisition, extraction, model training, and cleanup using HTCondor for job submission and resource management.

## **1. Data Access and Processing**

The workflow for handling the CIFAR-10 dataset starts with obtaining the dataset from the Open Science Data Federation (OSDF). This is achieved through a Python script that sends an HTTP GET request to download the dataset. The authorization token is used for authentication, and the dataset is retrieved as a compressed `.tar.gz` file.

**Steps:**
1. **Data Acquisition:** Download the CIFAR-10 dataset from OSDF using an HTTP GET request.
2. **Data Extraction:** The dataset is saved locally on the compute node and extracted using a wrapper script. The tarball is decompressed, and the files are organized into a directory named `data`.
3. **Model Training:** The extracted dataset is used to train a PyTorch model. The wrapper script manages the training process by running the PyTorch model script.
4. **Cleanup:** After the model training is complete, the wrapper script removes the `data` directory to free up storage space on the compute node.

## **2. Data Flow**

The data flow for this process is as follows:

1. **Data Acquisition:** The CIFAR-10 dataset is downloaded from OSDF as a `.tar.gz` file.
2. **Data Extraction:** The wrapper script extracts the tarball and populates the `data` directory with the dataset files.
3. **Model Training:** The PyTorch model script is executed to train the model using the CIFAR-10 dataset.
4. **Cleanup:** Post-training, the `data` directory is deleted to clear up storage space on the compute node.
5. **Job Submission and Resource Management:** HTCondor manages the job submission, specifying the required resources and handling file transfers. It ensures the necessary files are available on the compute node and manages the execution of the PyTorch script.
6. **Execution Monitoring:** Logs are generated during execution to capture the job’s progress, output, and errors, aiding in debugging and monitoring.

## **3. Wrapper Script**

The wrapper script orchestrates the data preparation and model training process. It performs the following tasks:

1. **Extract Dataset:** Decompresses the CIFAR-10 dataset tarball and creates a `data` directory.
2. **Run Model Training:** Executes the PyTorch model script to train the model on the extracted dataset.
3. **Cleanup:** Deletes the `data` directory after training to reclaim storage space.

## **4. HTCondor Submit File**

The HTCondor submit file configures the job submission process and includes:

1. **Singularity Image:** Specifies the use of a Singularity container image containing PyTorch.
2. **Log Files:** Defines paths for log, error, and output files.
3. **Executable and Arguments:** Sets the executable (wrapper script) and its arguments.
4. **File Transfers:** Manages the transfer of necessary files (e.g., Python script, dataset) to the compute node.
5. **Resource Requests:** Requests computational resources such as CPUs, GPUs, memory, and disk space.
6. **Job Execution:** Ensures that the job is executed with the specified resources and that all necessary files are available on the compute node.

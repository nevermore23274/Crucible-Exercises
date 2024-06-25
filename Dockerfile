# Use the official PyTorch image as the base image
FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel

# Set noninteractive timezone configuration
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update -y && \
    apt-get install -y \
    git \
    build-essential \
    libssl-dev && \
    # Upgrade pip to the latest version
    pip install --no-cache-dir --upgrade pip && \
    # Install Jupyter and other Python packages using pip
    pip install --no-cache-dir jupyter pandas numpy matplotlib scikit-learn requests && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /workspace

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

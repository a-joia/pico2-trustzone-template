FROM ubuntu:latest

RUN apt update && apt install -y sudo \
    wget \
    curl \
    git \
    vim \
    openocd \
    dos2unix \
    usbutils \
    gdb-multiarch \
    udev \
    screen  \
    cmake \
    gcc-arm-none-eabi \
    ninja-build \
    build-essential  && \
    useradd -m -s /bin/bash neto && \
    echo "neto:password" | chpasswd && \
    usermod -aG sudo neto && \
    usermod -aG dialout neto && \
    echo "neto ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install openssh-server and configure
RUN apt update && apt install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config || true

# Allow password authentication (optional but common for SSH login)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Install miniconda and configure PATH
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    /opt/miniconda/bin/conda init && \
    echo 'export PATH="/opt/miniconda/bin:$PATH"' >> /home/neto/.bashrc && \
    /opt/miniconda/bin/pip install -U pyocd

RUN mkdir -p /etc/ssh /var/run/sshd && \
    yes | ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
    yes | ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

#activate conda base environment for neto user
RUN echo "source /opt/miniconda/bin/activate base" >> /home/neto/.bashrc && \
    echo "export PATH=/opt/miniconda/bin:$PATH" >> /home/neto/.bashrc && \
    chown neto:neto /home/neto/.bashrc 

# Update PATH for all future layers
ENV PATH="/opt/miniconda/bin:$PATH"

# Expose SSH port
EXPOSE 22

# Start sshd in foreground to keep container running
CMD ["/bin/bash", "-c", "mkdir -p /etc/ssh && ssh-keygen -A && exec /usr/sbin/sshd -D &&  /usr/lib/systemd/systemd-udevd --daemon"]


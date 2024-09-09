FROM ubuntu:24.04

RUN apt-get update && apt-get install -y debootstrap \
    && rm -rf /var/lib/apt/lists/*

RUN debootstrap noble /data

RUN apt-get update && apt-get install -y \
        openssh-server \
        rsync \
        schroot \
        vim \
    && rm -rf /var/lib/apt/lists/*

# config schroot
RUN mv /etc/schroot /data/
COPY schroot/schroot.conf /data/schroot/
COPY schroot/default/fstab /data/schroot/default/
RUN ln -sf /data/schroot/ /etc/schroot

# install in schroot env
COPY install.sh /data/
RUN schroot -c ubuntu /install.sh
RUN sed -i 's/# type=/type=/' /etc/schroot/schroot.conf

# config entrypoint
COPY entrypoint.sh /data/
COPY entrypoint-schroot.sh /data/
RUN mv /data /template && ln -sf /template/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN chmod +x /template/entrypoint.sh /template/entrypoint-schroot.sh

EXPOSE 22

CMD ["sleep", "infinity"]

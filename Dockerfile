# We are going to use the Latest version of Centos
FROM  snapcore/snapcraft:edge

RUN snap download kaffelogic-studio && unsquashfs -f -d kaffelogic-studio /kaffelogic-studio*.snap

#STAGE 2
FROM  ubuntu:focal

RUN apt update && apt install -y evince curl desktop-file-utils locales zlib1g && apt clean

RUN locale-gen en_GB.UTF-8
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Setting up the default locale to en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TZ="America/Boise"

COPY --from=0 /kaffelogic-studio/opt /opt
RUN mkdir -p /snap/kaffelogic-studio/current/
RUN ln -s /opt/ /snap/kaffelogic-studio/current/opt
RUN sh /snap/kaffelogic-studio/current/opt/kaffelogic-studio/ubuntu-snap-postinstall.sh

# Generating a universally unique ID for the Container
RUN  dbus-uuidgen > /etc/machine-id

RUN useradd -u 1000 -g root -ms /bin/bash kl
USER kl
RUN mkdir -p /home/kl/.Kaffelogic\ Studio
WORKDIR /home/kl
CMD "/opt/kaffelogic-studio/studio"

# We are going to use the Latest version of Centos
FROM  ubuntu:focal

RUN apt update && apt install -y evince curl desktop-file-utils locales && apt clean

RUN locale-gen en_GB.UTF-8
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Setting up the default locale to en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TZ="Europe/Lisbon"

ARG KAFFELOGIC_STUDIO=kaffelogic-studio_5.0.14_amd64.deb
RUN curl https://kaffelogic.com/downloads/$KAFFELOGIC_STUDIO -o /tmp/$KAFFELOGIC_STUDIO \
        && dpkg -i /tmp/$KAFFELOGIC_STUDIO \
        && rm /tmp/$KAFFELOGIC_STUDIO

# Generating a universally unique ID for the Container
RUN  dbus-uuidgen > /etc/machine-id

RUN useradd -u 1000 -g root -ms /bin/bash kl
USER kl
WORKDIR /home/kl
CMD "/opt/kaffelogic-studio/Kaffelogic Studio"

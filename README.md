*Forked from [https://github.com/flaper87/kaffelogic-studio-container](https://github.com/fatalsaint/kaffelogic-studio-container)*

# kaffelogic-studio-container

Container Image for Kaffelogic Studio

Kaffelogic changed their distribution method from Deb files to using Snap package manager making the original image no longer work.  Since not all distro's use snap, I built a way to retrieve and extract the latest build and execute KL studio.

# Building and Updating

Clone this repo, cd into the directory, and then run:

```
$ docker build --no-cache -f Dockerfile . -t kaffelogic-studio:latest
```

# Running

1. Copy the kaffelogic-studio script somewhere in your $PATH 
```sudo cp ./kaffelogic-studio ./usr/local/bin/kaffelogic-studio```
2. Copy the udev rules file in /etc/udev/rules.d/
3. sudo udevadm control --reload-rules && sudo udevadm trigger
4. Launch kaffelogic-studio

Note: ensure user is in dialout group. 

*Note: The udev portions are important to get KL Studio to recognize the USB*

*Note: If you have an older Kaffelogic that used the USB Drive, please mount your USB to "/media/$USER/USB DISK"*

The above assumes your user's id is 1000 (currently hard-coded in the container image)

# Known Issue

If you run into a problem building this container seeing an error:

```
FATAL ERROR:Data queue size is too large
```

This is an issue with an interaction between squashfs and the system LimitNOFILE setting "infinity" that is being set by default in containerd which is a backing of newer versions of Docker.

See: https://github.com/canonical/lxd/issues/5449

To fix this, copy the included containerd.service.d folder to systemd and override this parameter.  You will then need to reload containerd service.  This example uses systemd, as it is most common, but if you use another Init manager like openrc or runit you'll need to convert this.

```
$ sudo cp -r containerd.service.d /etc/systemd/system  
$ sudo systemctl daemon-reload
$ sudo systemctl restart containerd
```

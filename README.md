*Forked from https://github.com/flaper87/kaffelogic-studio-container*

# kaffelogic-studio-container

Container Image for Kaffelogic Studio

Kaffelogic changed their distribution method from Deb files to using Snap package manager making the original image no longer work.  Since not all distro's use snap, I built a way to retrieve and extract the latest build and execute KL studio.

# Build

Clone this repo, cd into the directory, and then run:

```
$ docker build -f Dockerfile . -t kaffelogic-studio:latest
```

# Running

1. Copy the kaffelogic-studio script somewhere in your $PATH
2. Copy the udev rules file in /etc/udev/rules.d/
3. sudo udevadm control --reload-rules && sudo udevadm trigger
4. Launch kaffelogic-studio
*Note: The udev portions are important to get KL Studio to recognize the USB*

The above assumes your user's id is 1000 (currently hard-coded in the container image)

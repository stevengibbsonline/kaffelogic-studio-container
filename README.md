# kaffelogic-studio-container

Container Image for Kaffelogic Studio

I was basically having troubles getting Kaffelogic Studio to run on newer
distributions of Linux so I went ahead and put it inside a container to
workaround the issues I found.

# Build

Clone this repo, cd into the directory, and then run:

```
$ docker build -f Dockerfile . -t kaffelogic-studio:latest
```

It is possible to optionally pass a KAFFELOGIC_STUDIO argument to the build with the full name of the deb package:

```
$ docker build --build-arg KAFFELOGIC_STUDIO=kaffelogic-studio_5.0.14_amd64.deb -f Dockerfile . -t kaffelogic-studio:latest
```

# Running

You can manually run the container as root. I've added a `kaffelogic-studio`
script that runs the container as an unprivileged user, which avoids permission
issues on the files after syncs.

1. Copy the kaffelogic-studio script somewhere in your $PATH
2. Copy the udev rules file in /etc/udev/rules.d/
3. sudo udevadm control --reload-rules && sudo udevadm trigger
4. Launch kaffelogic-studio


The above assumes your user's id is 1000 (currently hard-coded in the container image)

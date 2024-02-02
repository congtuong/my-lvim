# My Lvim Config and Docker

This repository contains my LunarVim configuration with autocompletions and Copilot, plus a Dockerfile
to run the configuration in a container.

## Getting Started

To get started, clone the repository:

```
git clone https://github.com/congtuong/my-lvim.git
```

### Building the Container

Use `./build.sh` to create the Docker image or just run the following command:

```bash
~$ docker build tuongbck_lvim .
```

This script will build the container and tag it with the name `tuongbck-lvim`.

### Running the Container

There is a helper script to start up the container `./run.sh` or just start it like normal.

```bash
~$ ./run.sh
```




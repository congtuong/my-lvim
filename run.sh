#!/usr/bin/env bash
docker rm tuongbck_lvim 2&> /dev/null
docker run -it \
  --name tuongbck_lvim \
  --mount type=bind,source="/",target=/mount \
  tuongbck_lvim


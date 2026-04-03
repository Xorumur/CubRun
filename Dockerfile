FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
	gcc \
	make \
	libx11-dev \
	libxext-dev \
	git \
	&& rm -rf /var/lib/apt/lists/*

COPY lib/minilibx-linux.tgz /tmp/
RUN tar -xzf /tmp/minilibx-linux.tgz -C /opt/ \
	&& mv /opt/minilibx-linux /opt/mlx \
	&& make -C /opt/mlx; test -f /opt/mlx/libmlx.a \
	&& rm /tmp/minilibx-linux.tgz

WORKDIR /app

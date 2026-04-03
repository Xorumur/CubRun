FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
	gcc \
	make \
	libx11-dev \
	libxext-dev \
	git \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

FROM debian:jessie
MAINTAINER Chris Parker <mrcsparker@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y \
      wget \
      curl \
      locales \
      git \
      build-essential

# locale
RUN echo "en_US UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN rm erlang-solutions_1.0_all.deb

RUN apt-get update

RUN apt-get install -y esl-erlang

RUN apt-get clean

ENV ELIXIR_VERSION 1.2.3

RUN git clone https://github.com/elixir-lang/elixir.git && \
    cd elixir && \
      git checkout tags/v${ELIXIR_VERSION} && \
      make && make install && \
    cd .. && rm -rf elixir

RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force

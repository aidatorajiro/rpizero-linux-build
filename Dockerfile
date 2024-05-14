FROM ubuntu:latest
COPY apt.sh .
RUN sh apt.sh
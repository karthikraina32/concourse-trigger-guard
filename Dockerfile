FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y jq
RUN apt-get install -y curl
COPY check in out /opt/resource/
RUN chmod +x /opt/resource/*
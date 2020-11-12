FROM netbootxyz/docker-builder:latest as builder

ENV DEBIAN_FRONTEND=noninteractive

RUN \
 echo "**** install deps ****" && \
 apt-get update && \
 apt-get install -y \
      git \
      python3-pip \
      python3-setuptools

# repo for build
COPY . /ansible

RUN pip3 install ansible

RUN \
 echo "**** running ansible ****" && \
 cd /ansible && \
 ansible-playbook -i inventory site.yml

# runtime stage
FROM alpine:3.12

COPY --from=builder /opt/builders/output /mnt/
COPY docker-build-root/ /

ENTRYPOINT [ "/dumper.sh" ]

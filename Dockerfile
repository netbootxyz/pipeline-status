FROM ghcr.io/netbootxyz/builder:latest as builder

ENV DEBIAN_FRONTEND=noninteractive

# repo for build
COPY . /ansible

RUN pip3 install ansible

RUN \
 echo "**** running ansible ****" && \
 cd /ansible && \
 ansible-playbook -i inventory site.yml

# runtime stage
FROM alpine:3.21

COPY --from=builder /opt/builders/output /mnt/
COPY docker-build-root/ /

ENTRYPOINT [ "/dumper.sh" ]

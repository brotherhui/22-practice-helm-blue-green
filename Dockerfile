FROM frolvlad/alpine-oraclejdk8:slim

RUN addgroup -S nextgengroup && \
    adduser -S -D nextgen -G nextgengroup
RUN find / -perm +6000 -type f -exec chmod a-s {} \; || true
USER nextgen
WORKDIR /tmp
COPY helloworld.jar /tmp
EXPOSE 8080
CMD java -jar helloworld.jar
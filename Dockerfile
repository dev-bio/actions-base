FROM gcr.io/distroless/cc-debian11@sha256:3603adbdee2906dc3b7a18d7c0424a40633231c61dcd82196ae15de1282a5822 as runtime
FROM busybox@sha256:3fbc632167424a6d997e74f52b878d7cc478225cffac6bc977eedfe51c7f4e79 as setup

COPY --from=runtime /etc/group /etc/passwd /etc/

RUN echo "runner:x:1001:121:runner:/home/runner:/sbin/nologin" >> /etc/passwd && \
    echo "runner:x:121:runner" >> /etc/group

FROM runtime

COPY --from=setup /etc/passwd /etc/group /etc/

USER runner:runner

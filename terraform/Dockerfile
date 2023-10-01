ARG PLATFORM
FROM --platform=${PLATFORM:-linux/amd64} hashicorp/terraform:1.5.0

WORKDIR /root

RUN apk update && \
    apk add \
    bash \
    wget \
    curl \
    vim \
    git && \
    rm -rf /var/cache/apk/*

ENV RUNNING_IN_DOCKER true
ENV TZ=America/Sao_Paulo
ENV TERM xterm

# Install oh-my-bash
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"


# Start bash
ENTRYPOINT [ "bash" ]

ARG PLATFORM
FROM --platform=${PLATFORM:-linux/amd64} hashicorp/packer:1.9.4

WORKDIR /root

RUN apk update && \
    apk add \
    zsh \
    wget \
    curl \
    vim \
    make \
    git && \
    rm -rf /var/cache/apk/*

ENV RUNNING_IN_DOCKER true
ENV TZ=America/Sao_Paulo
ENV TERM xterm

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Start zsh
CMD [ "zsh" ]

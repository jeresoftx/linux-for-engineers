FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        bash \
        ca-certificates \
        coreutils \
        curl \
        dnsutils \
        file \
        findutils \
        gawk \
        grep \
        iproute2 \
        iputils-ping \
        less \
        netcat-openbsd \
        openssh-client \
        procps \
        psmisc \
        ripgrep \
        rsync \
        sed \
        util-linux \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash learner

WORKDIR /course
COPY --chown=learner:learner scripts /course/scripts
COPY --chown=learner:learner labs /course/labs
COPY --chown=learner:learner exercises /course/exercises
COPY --chown=learner:learner solutions /course/solutions
COPY --chown=learner:learner tests /course/tests

USER learner
ENV LAB_ROOT=/tmp/linux-for-engineers
ENTRYPOINT ["/bin/bash"]

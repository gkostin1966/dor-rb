FROM ruby:3.2 AS rb

ARG UNAME=app
ARG UID=1000
ARG GID=1000

# Install necessary and useful tools
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    curl \
    vim-tiny

# Create user group and user 
RUN groupadd -g ${GID} -o ${UNAME}
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}

# Install bundler
RUN gem install bundler

# Create gem directory
RUN mkdir -p /gems && chown ${UID}:${GID} /gems
ENV BUNDLE_PATH /gems

# Create app directory
RUN mkdir -p /app && chown ${UID}:${GID} /app




FROM rb AS rocfl

ARG GITHUB_ROCFL_BRANCH=umich

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    wget \
    unzip

ENV GITHUB_ROCFL_BRANCH=${GITHUB_ROCFL_BRANCH}

RUN wget -q https://github.com/mlibrary/rocfl/archive/refs/heads/${GITHUB_ROCFL_BRANCH}.zip && \
    unzip -q ./${GITHUB_ROCFL_BRANCH}.zip -d . && \
    rm -rf ./${GITHUB_ROCFL_BRANCH}.zip && \
    mv ./rocfl-${GITHUB_ROCFL_BRANCH} ./rocfl




FROM rb AS rbrs    

# Set the working directory to user home directory
WORKDIR /home/${UNAME}

# Copy rocfl source to user home directory
COPY --from=rocfl --chown=${UNAME} /rocfl ./rocfl

# Switch to user
USER ${UNAME}

# Install rust toolchain in user home directory
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/${UNAME}/.cargo/bin:$PATH"

# Install rocfl
RUN cargo install --path ./rocfl

# Install SQLx CLI
RUN cargo install sqlx-cli




FROM rbrs AS development

# Set the working directory to /app
WORKDIR /app

USER ${UNAME}

CMD ["tail", "-f", "/dev/null"]







FROM base AS production

COPY --chown=${UID}:${GID} . /app

WORKDIR /app

USER ${UNAME}

RUN bundle  install


FROM rust:latest
COPY . .
# Install clang (required for dependencies)
RUN apt-get update \
    && apt-get install -y clang libclang-dev libpq-dev libssl-dev pkg-config

# Clone and build the graph-node repository
#fix
#RUN rustup component add rustfmt
RUN cargo build

# Clone and install wait-for-it
RUN git clone https://github.com/vishnubob/wait-for-it \
    && cp wait-for-it/wait-for-it.sh /usr/local/bin \
    && chmod +x /usr/local/bin/wait-for-it.sh \
    && rm -rf wait-for-it

ENV postgres_host ""
ENV postgres_user ""
ENV postgres_pass ""
ENV postgres_db ""
ENV ipfs ""
ENV ethereum ""

# Start everything on startup
ADD start-node /usr/local/bin
CMD wait-for-it.sh $ipfs -t 30 \
    && wait-for-it.sh $postgres_host -t 30 \
    && sleep 5 \
    && start-node

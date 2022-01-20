FROM rust:latest
COPY . .
# Install clang (required for dependencies)
RUN apt-get update \
    && apt-get install -y clang libclang-dev libpq-dev libssl-dev pkg-config

# Clone and build the graph-node repository
#fix
RUN rustup component add rustfmt
RUN cargo build

# Start everything on startup
CMD graph-node --debug -V --ethereum-rpc dev:http://localhost:8545 --ipfs localhost:5001 --postgres-url postgresql://nomo:nomo@localhost:5050/nomo

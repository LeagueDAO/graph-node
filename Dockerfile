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
CMD cargo run -p graph-node --release -- \
  --postgres-url postgresql://nomo:nomo@postgres-graf-master:5050/nomo \
  --ethereum-rpc dev:http://parity-master:8545 \
  --ipfs ipfs-master:5001

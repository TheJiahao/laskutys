build:
    cd tools;\
    cargo build --release --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/release/tools.wasm tools.wasm;

dev:
    cd tools;\
    cargo build --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/debug/tools.wasm tools.wasm;

install-dev-deps:
    rustup component add rustfmt clippy

test:
    cargo test

lint:
    cargo clippy

format:
    cargo fmt

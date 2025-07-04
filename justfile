build:
    cd rust-tools;\
    cargo build --release --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/release/rust_tools.wasm rust_tools.wasm;

dev:
    cd rust-tools;\
    cargo build --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/debug/rust_tools.wasm rust_tools.wasm;

install-dev-deps:
    rustup component add rustfmt clippy

test:
    cd rust-tools;\
    cargo test

lint:
    cd rust-tools;\
    cargo clippy

lint-fix:
    cd rust-tools;\
    cargo clippy --fix

format:
    cd rust-tools;\
    cargo fmt

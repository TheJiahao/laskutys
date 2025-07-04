build:
    cd rust-tools;\
    cargo --color=always build --release --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/release/rust_tools.wasm rust_tools.wasm;

dev:
    cd rust-tools;\
    cargo --color=always build --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/debug/rust_tools.wasm rust_tools.wasm;

install-dev-deps:
    rustup component add rustfmt clippy

test:
    cd rust-tools;\
    cargo --color=always test

lint:
    cd rust-tools;\
    cargo --color=always clippy

lint-fix:
    cd rust-tools;\
    cargo --color=always clippy --fix

format:
    cd rust-tools;\
    cargo --color=always fmt

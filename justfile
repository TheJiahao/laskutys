build:
    cd tools;\
    cargo build --release --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/release/tools.wasm tools.wasm;

build-dev:
    cd tools;\
    cargo build --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/release/tools.wasm tools.wasm;
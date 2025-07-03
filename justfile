build:
    cd tools; \
    cargo build --release \
        --target wasm32-unknown-unknown; \
    cp target/wasm32-unknown-unknown/release/tools.wasm tools.wasm
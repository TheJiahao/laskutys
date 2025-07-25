build:
    cd rust_tools;\
    cargo build --release --target wasm32-unknown-unknown;\
    cp target/wasm32-unknown-unknown/release/rust_tools.wasm rust_tools.wasm;

install-dev-deps:
    rustup component add rustfmt clippy
    cargo install cargo-binstall --locked
    cargo binstall typstyle tytanic typst-cli --locked

test:
    tt run
    cd rust_tools;\
    cargo test

lint:
    cd rust_tools;\
    cargo clippy

lint-fix:
    cd rust_tools;\
    cargo clippy --fix

format:
    typstyle -i .
    cd rust_tools;\
    cargo fmt

install target:
    showman package ./typst.toml -o -n {{target}}

img_dir := "docs/images"

render-thumbnail:
    typst compile template/main.typ {{img_dir}}/thumbnail.png --root . --ppi 250
    cwebp {{img_dir}}/thumbnail.png -lossless -o {{img_dir}}/thumbnail.webp
    rm {{img_dir}}/thumbnail.png

render: render-thumbnail
    cd .;\
    for file in `ls {{img_dir}}/*.typ`;\
        do typst compile $file -f svg --root .;\
    done

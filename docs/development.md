# Development

This package is developed in Ubuntu 24.04 (WSL) but the instructions should work for other operating systems as well.

## Configure environment

1. Install rustup and cargo by following the guides in https://www.rust-lang.org/tools/install

1. Install WASM target

    ```console
    rustup target add wasm32-unknown-unknown    
    ```

1. Install [just](https://github.com/casey/just) to run commands

    ```console
    cargo install just
    ```

1. Install development tools

    ```console
    just install-dev-deps
    cargo install --locked typstyle tytanic
    ```

    > [!NOTE]
    > `install-dev-deps` is mostly for CI.
    > It does not install crates, since they are installed with cargo-install that caches them

## Commands

Run tests:

```console
just test
```

Lint code:

```console
just lint
```

Format code:

```console
just format
```

Build Rust binary (release) and copy WASM file:

```console
just build
```

Build Rust binary (dev) and copy WASM file:

```console
just dev
```

Render all preview images

```console
just render
```

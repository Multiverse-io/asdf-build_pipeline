<div align="center">

# asdf-build_pipeline [![Build](https://github.com/mbernerslee/asdf-build_pipeline/actions/workflows/build.yml/badge.svg)](https://github.com/mbernerslee/asdf-build_pipeline/actions/workflows/build.yml) [![Lint](https://github.com/mbernerslee/asdf-build_pipeline/actions/workflows/lint.yml/badge.svg)](https://github.com/mbernerslee/asdf-build_pipeline/actions/workflows/lint.yml)


[build_pipeline](https://github.com/Multiverse-io/build_pipeline) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add build_pipeline
# or
asdf plugin add build_pipeline https://github.com/mbernerslee/asdf-build_pipeline.git
```

build_pipeline:

```shell
# Show all installable versions
asdf list-all build_pipeline

# Install specific version
asdf install build_pipeline latest

# Set a version globally (on your ~/.tool-versions file)
asdf global build_pipeline latest

# Now build_pipeline commands are available
bp --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/mbernerslee/asdf-build_pipeline/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Matthew Berners-Lee](https://github.com/mbernerslee/)

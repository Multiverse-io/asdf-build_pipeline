# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test build_pipeline https://github.com/mbernerslee/asdf-build_pipeline.git "bp --version"
```

Tests are automatically run in GitHub Actions on push and PR.

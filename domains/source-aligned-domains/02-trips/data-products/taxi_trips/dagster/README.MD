# Boilerplate Dagster project

Adapt the boilerplate to your project by:
- Configuring the [pyproject.toml](pyproject.toml) file (`tool.poetry.name`, `tool.dagster.module_name`)
- Configuring the [setup.cfg](setup.cfg) file, `metadata.name` must match `tool.dagster.module_name`

## Project structure




## Development environment

### Virtual environment

```console
poetry config virtualenvs.in-project true
poetry install
poetry shell
```

> In your IDE don’t forget to target the `.venv/bin/python` to manage correctly your development and be able to run in debug mode!


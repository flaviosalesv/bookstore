# Use a imagem oficial do Python como base
FROM python:3.12-slim as python-base

# Defina as variáveis de ambiente compartilhadas
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.0.3 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

# Adicione o diretório do Poetry ao PATH
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# Atualize e instale as dependências necessárias
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl \
        build-essential \
        libpq-dev \
        gcc \
    && rm -rf /var/lib/apt/lists/*

# Instale o Poetry
RUN pip install poetry

# Crie e defina o diretório de trabalho
WORKDIR /app

# Copie os arquivos de dependência do projeto
COPY poetry.lock pyproject.toml /app/

# Instale as dependências do projeto
RUN poetry install --no-dev

# Instale o Django
RUN pip install django

# Copie o restante dos arquivos do projeto para o diretório de trabalho
COPY . /app

# Exponha a porta 8000 para o mundo exterior
EXPOSE 8000

# Comando padrão para executar a aplicação
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM python:3.12-slim

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    python3-dev \
    gfortran \
    liblapack-dev \
    libblas-dev

# Reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install latest pip and lock in poetry version
RUN pip install --upgrade pip && pip install poetry==1.6.1

# Install and run the app dependencies in /app directory
RUN mkdir /app
COPY . /app
WORKDIR /app
# EXPOSE 8080
RUN poetry config virtualenvs.create false
RUN poetry install
ENTRYPOINT ["gunicorn", "--config", "gunicorn_config.py", "main:app"]
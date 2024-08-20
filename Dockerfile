FROM python:3.10.0-alpine3.15

LABEL maintener="igorcfreittas@gmail.com"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ ${DEV} = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

WORKDIR /app

EXPOSE 8000

USER django-user
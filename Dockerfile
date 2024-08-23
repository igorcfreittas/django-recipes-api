FROM python:3.10.0-alpine3.15

LABEL maintener="igorcfreittas@gmail.com"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app

ARG DEV=false

ENV PATH="/usr/lib/postgresql/X.Y/bin/:$PATH"

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client &&  \
    apk add --update --no-cache postgresql-libs && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        gcc build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ ${DEV} = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

WORKDIR /app

EXPOSE 8000

USER django-user
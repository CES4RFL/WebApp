FROM python:3.11.5-alpine3.18

ENV PYTHONUNBUFFERED 1

WORKDIR /WebApp

ARG AWS_ACCESS_KEY_ID
ENV AWS_ACCESS_KEY_ID ${AWS_ACCESS_KEY_ID}

ARG AWS_SECRET_ACCESS_KEY
ENV AWS_SECRET_ACCESS_KEY ${AWS_SECRET_ACCESS_KEY}

ARG OTEL_SERVICE_NAME
ENV OTEL_SERVICE_NAME ${OTEL_SERVICE_NAME}

ARG HONEYCOMB_API_KEY
ENV HONEYCOMB_API_KEY ${HONEYCOMB_API_KEY}

ARG DJANGO_SETTINGS_MODULE
ENV DJANGO_SETTINGS_MODULE ${DJANGO_SETTINGS_MODULE}

COPY requirements.txt /WebApp/

RUN apk update && apk add bash

RUN python -m pip install -r requirements.txt

RUN python -m pip install honeycomb-opentelemetry==0.2.2b0

Run opentelemetry-bootstrap --action=install

COPY . /WebApp/

#CMD ["python","manage.py","runserver","0.0.0.0:8080"]

CMD ["opentelemetry-instrument","python","manage.py","runserver","0.0.0.0:8080","--noreload"]
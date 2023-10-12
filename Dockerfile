FROM python:3.11.5-alpine3.18

ENV PYTHONUNBUFFERED 1

WORKDIR /WebApp

ARG AWS_ACCESS_KEY_ID
ENV AWS_ACCESS_KEY_ID ${AWS_ACCESS_KEY_ID}

ARG AWS_SECRET_ACCESS_KEY
ENV AWS_SECRET_ACCESS_KEY ${AWS_SECRET_ACCESS_KEY}

COPY requirements.txt /WebApp/

RUN apk update && apk add bash

RUN python -m pip install -r requirements.txt

COPY . /WebApp/

CMD ["python","manage.py","runserver","0.0.0.0:8080"]
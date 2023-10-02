FROM python:3.11.5-alpine3.18

ENV PYTHONUNBUFFERED 1

WORKDIR /WebApp

COPY requirements.txt /WebApp/

RUN apk update && apk add bash

RUN python -m pip install -r requirements.txt

COPY . /WebApp/

CMD ["python","manage.py","runserver","0.0.0.0:8080"]
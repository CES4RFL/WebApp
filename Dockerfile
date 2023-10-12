FROM python:3.11.5-alpine3.18

ENV PYTHONUNBUFFERED 1

WORKDIR /WebApp

RUN --mount=type=secret,id=ident \
    cat /run/secrets/ident  

RUN --mount=type=secret,id=key \
   cat /run/secrets/key 

RUN export AWS_ACCESS_KEY_ID=$(cat /run/secrets/ident) 
RUN export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/key)

COPY requirements.txt /WebApp/

RUN apk update && apk add bash

RUN python -m pip install -r requirements.txt

COPY . /WebApp/

CMD ["python","manage.py","runserver","0.0.0.0:8080"]
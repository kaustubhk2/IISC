# syntax=docker/dockerfile:1
FROM busybox:latest

COPY requirements.txt requirements.txt

RUN python -m pip install -r requirements.txt
RUN pip install joblib

COPY Train.csv ./train.csv
COPY Test.csv ./test.csv


COPY inference.py ./inference.py

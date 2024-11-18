# syntax=docker/dockerfile:1
FROM tensorflow/serving

COPY requirements.txt requirements.txt

RUN python -m pip install -r requirements.txt
RUN pip install joblib

COPY content/Train.csv ./train.csv
COPY content/Test.csv ./test.csv


COPY inference.py ./inference.py

COPY model/1 /models/CNN

ENV MODEL_NAME CNN

ENTRYPOINT ["/usr/bin/tf_serving_entrypoint.sh"]
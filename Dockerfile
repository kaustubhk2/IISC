# syntax=docker/dockerfile:1
#FROM tensorflow/serving

FROM python:3.10.11


RUN apt-get update

COPY requirements.txt requirements.txt
RUN python -m pip install -r requirements.txt
#RUN pip install joblib

COPY fastapi.py ./fastapi.py
#COPY content/Train.csv ./train.csv
#COPY content/Test.csv ./test.csv


#COPY inference.py ./inference.py

COPY model /models/CNN
COPY CNN.h5 cnn.h5

ENV MODEL_NAME=CNN

# Expose the port on which the app will run
EXPOSE 8000

# Command to run the  app
CMD [ "python", "fastapi.py" ]


#CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
#ENTRYPOINT ["/usr/bin/tf_serving_entrypoint.sh"]
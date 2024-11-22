import json
import base64
import uuid
import os
import pandas as pd
import numpy as np
import io
from io import StringIO,BytesIO
import tensorflow
import keras
from tensorflow.keras.models import load_model
import numpy as np
from PIL import Image
from fastapi import FastAPI, File, UploadFile 

app = FastAPI()

# Load the saved CNN model
model = load_model('cnn.h5')  # Replace 'cnn.h5' with your model's path

# Preprocess the image
def preprocess_image(image_path):
    img = Image.open(image_path)
    img = img.resize((224, 224))  # Adjust dimensions as needed
    img = np.array(img) / 255.0  # Normalize pixel values
    img = np.expand_dims(img, axis=0)  # Add a batch dimension
    return img

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    contents = await file.read()
    image_path = "temp_image.jpg"
    with open(image_path, "wb") as f:
        f.write(contents)

    preprocessed_image = preprocess_image(image_path)
    prediction = model.predict(preprocessed_image)

    # Process the prediction result as needed (e.g., class labels, probabilities)
    # ...

    return {"prediction": prediction.tolist()}




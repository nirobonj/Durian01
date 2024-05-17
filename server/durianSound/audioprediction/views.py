# views.py
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
import numpy as np
import librosa as lb
from keras.models import load_model
import os

# Define classes
# classes = ['air_conditioner', 'car_horn', 'children_playing', 'dog_bark', 'drilling',
#            'engine_idling', 'gun_shot', 'jackhammer', 'siren', 'street_music']

classes = ['ดิบ', 'กึ่งสุกกึ่งดิบ', 'สุกกรอบนอกนุ่มใน', 'sdfds', 'ddd']

# Function to extract features from audio file


def feature_extractor(path):
    data, sample_rate = lb.load(path)
    data = lb.feature.mfcc(y=data, sr=sample_rate, n_mfcc=128)
    data = np.mean(data, axis=1)
    return data

# Function to preprocess the audio file and make prediction


def predict_audio(path):
    # Load the trained model
    current_directory = os.path.dirname(os.path.abspath(__file__))
    # MODEL_PATH = 'audio_classification_model.h5'
    MODEL_PATH = 'soundCheck.h5'
    current_directory += '/'+MODEL_PATH
    # print(current_directory)
    model = load_model(current_directory)

    # Extract features from audio file
    audio_features = feature_extractor(path)
    # Reshape the features
    audio_features = audio_features.reshape(1, -1)
    # Make prediction
    prediction = model.predict(audio_features)
    # Get the predicted class
    predicted_class_index = np.argmax(prediction)
    predicted_class = classes[predicted_class_index]

    print("Predicted class index:", predicted_class_index)
    print("Predicted class:", predicted_class)
    return predicted_class


@csrf_exempt
def predict(request):
    if request.method == 'POST' and request.FILES['audio']:
        audio_file = request.FILES['audio']

        # Save the audio file
        audio_path = default_storage.save(
            'uploaded_audio.wav', ContentFile(audio_file.read()))

        # Make prediction
        predicted_class = predict_audio(audio_path)

        return JsonResponse({'predicted_class': predicted_class}, status=200)
    else:
        return JsonResponse({'error': 'No audio file provided'}, status=400)


def hello(request):
    return JsonResponse({'message': 'Hello, Django!'}, status=200)

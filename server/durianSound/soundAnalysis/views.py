from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import os
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier


classes = ['ดิบ', 'กึ่งสุกกึ่งดิบ', 'สุกกรอบนอกนุ่มใน', 'sdfds', 'ddd']


def hello(request):
    data = {"name": "Hello"}
    return JsonResponse(data)


def feature_extraction(file_path):
    data, sample_rate = lb.load(file_path)
    mfccs = lb.feature.mfcc(y=data, sr=sample_rate, n_mfcc=13)
    mfccs_mean = np.mean(mfccs)
    mfccs_std = np.std(mfccs)
    zcr = np.mean(lb.feature.zero_crossing_rate(data)[0])
    spectral_centroid = np.mean(
        lb.feature.spectral_centroid(y=data, sr=sample_rate)[0])
    spectral_bandwidth = np.mean(
        lb.feature.spectral_bandwidth(y=data, sr=sample_rate)[0])
    rms_energy = np.mean(lb.feature.rms(y=data)[0])
    pitches, _ = lb.piptrack(y=data, sr=sample_rate)
    pitch = np.mean(pitches)
    return mfccs_mean, mfccs_std, zcr, spectral_centroid, spectral_bandwidth, rms_energy, pitch


def predict_audio(path):
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

    # @csrf_exempt
    # def upload_file(request):
    #     if request.method == 'POST' and 'audio' in request.FILES:
    #         audio_file = request.FILES['audio']
    #         # Process the uploaded file as needed
    #         # For example, save it to the filesystem
    #         current_dir = os.getcwd()
    #         upload_dir = os.path.join(current_dir, 'uploads')

    #         # Create the 'uploads' directory if it doesn't exist
    #         if not os.path.exists(upload_dir):
    #             os.makedirs(upload_dir)

    #         with open(os.path.join(upload_dir, audio_file.name), 'wb') as destination:
    #             for chunk in audio_file.chunks():
    #                 destination.write(chunk)
    #         return JsonResponse({'message': 'File uploaded successfully'})
    #     else:
    #         return JsonResponse({'error': 'No file uploaded'}, status=400)

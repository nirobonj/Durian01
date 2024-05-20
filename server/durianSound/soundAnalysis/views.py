from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import os
import pandas as pd
from sklearn.preprocessing import StandardScaler
import joblib
import librosa as lb
import numpy as np


def hello(request):
    data = {"name": "Hello"}
    return JsonResponse(data)


# Load the pre-trained KNN model
current_directory = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = 'knn_durian.joblib'
current_directory += '/'+MODEL_PATH
knn_model = joblib.load(current_directory)

# Function to extract features from audio file


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


@csrf_exempt
def predict(request):
    if request.method == 'POST' and 'audio' in request.FILES:
        # Receive the audio file
        audio_file = request.FILES['audio']

        # Save the uploaded file
        current_dir = os.getcwd()
        upload_dir = os.path.join(current_dir, 'uploads')
        if not os.path.exists(upload_dir):
            os.makedirs(upload_dir)
        with open(os.path.join(upload_dir, audio_file.name), 'wb') as destination:
            for chunk in audio_file.chunks():
                destination.write(chunk)

        new_data = feature_extraction(
            os.path.join(upload_dir, audio_file.name))

        new_data_reshaped = np.array(new_data).reshape(1, -1)
        predictions = knn_model.predict(new_data_reshaped)
        print(predictions)

        # Return the predictions
        return JsonResponse({'predictions': '1'})
    else:
        return JsonResponse({'error': 'No file uploaded'}, status=400)

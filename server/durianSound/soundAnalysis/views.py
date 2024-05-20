from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import os
import pandas as pd
import numpy as np
import librosa as lb

class_means = {
    4: 1.241317,
    3: 1.289005,
    5: 1.664476,
    2: 1.858263,
    6: 2.175524
}


def hello(request):
    data = {"name": "Hello"}
    return JsonResponse(data)


def feature_extraction(file_path):
    data, sample_rate = lb.load(file_path)
    mfccs = lb.feature.mfcc(y=data, sr=sample_rate, n_mfcc=13)
    mfccs_mean = np.mean(mfccs)
    return mfccs_mean


@csrf_exempt
def predict(request):
    if request.method == 'POST' and 'audio' in request.FILES:
        # Receive the audio file
        audio_file = request.FILES['audio']

        mfccs_mean = feature_extraction(audio_file)
        nearest_class = min(class_means, key=lambda x: abs(
            class_means[x] - mfccs_mean))

        print(nearest_class)
        return JsonResponse({'predictions': nearest_class})
    else:
        return JsonResponse({'error': 'No file uploaded'}, status=400)

from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import os
import pandas as pd
import numpy as np
import librosa as lb
import tempfile

class_means = {
    4: 1.241317,
    3: 1.289005,
    5: 1.664476,
    2: 1.858263,
    6: 2.175524
}


def feature_extraction(file_path):
    try:
        # sr=None keeps the original sample rate
        data, sample_rate = lb.load(file_path, sr=None)
        mfccs = lb.feature.mfcc(y=data, sr=sample_rate, n_mfcc=13)
        mfccs_mean = np.mean(mfccs)
        return mfccs_mean
    except Exception as e:
        print(f"Error during feature extraction: {e}")
        return None


@csrf_exempt
def predict(request):
    if request.method == 'POST' and 'audio' in request.FILES:
        # Receive the audio file
        audio_file = request.FILES['audio']

        with tempfile.NamedTemporaryFile(delete=False) as tmp_file:
            for chunk in audio_file.chunks():
                tmp_file.write(chunk)
            tmp_file_path = tmp_file.name

        mfccs_mean = feature_extraction(tmp_file_path)

        # Delete the temporary file after feature extraction
        os.remove(tmp_file_path)

        if mfccs_mean is not None:
            nearest_class = min(class_means, key=lambda x: abs(
                class_means[x] - mfccs_mean))
            return JsonResponse({'predictions': nearest_class})
        else:
            return JsonResponse({'error': 'Error in feature extraction'}, status=500)
    else:
        return JsonResponse({'error': 'No file uploaded'}, status=400)

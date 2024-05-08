from django.shortcuts import render
# ตัวอย่าง views.py
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
import numpy as np
# import librosa as lb
# from keras.models import load_model


def hello(request):
    return JsonResponse({'message': 'Hello, Django!'}, status=200)

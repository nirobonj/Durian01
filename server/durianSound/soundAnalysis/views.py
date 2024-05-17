from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import os


def hello(request):
    data = {"name": "Hello"}
    return JsonResponse(data)


@csrf_exempt
def upload_file(request):
    if request.method == 'POST' and 'audio' in request.FILES:
        audio_file = request.FILES['audio']
        # Process the uploaded file as needed
        # For example, save it to the filesystem
        current_dir = os.getcwd()
        upload_dir = os.path.join(current_dir, 'uploads')

        # Create the 'uploads' directory if it doesn't exist
        if not os.path.exists(upload_dir):
            os.makedirs(upload_dir)

        with open(os.path.join(upload_dir, audio_file.name), 'wb') as destination:
            for chunk in audio_file.chunks():
                destination.write(chunk)
        return JsonResponse({'message': 'File uploaded successfully'})
    else:
        return JsonResponse({'error': 'No file uploaded'}, status=400)

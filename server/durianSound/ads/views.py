from django.shortcuts import render, redirect
from .forms import AdForm
from rest_framework import viewsets
from .models import Ad
from .serializers import AdSerializer

def add_ad(request):
    if request.method == 'POST':
        form = AdForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('home')
    else:
        form = AdForm()
    return render(request, 'add_ad.html', {'form': form})

class AdViewSet(viewsets.ModelViewSet):
    queryset = Ad.objects.all()
    serializer_class = AdSerializer
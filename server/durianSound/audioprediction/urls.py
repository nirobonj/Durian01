from django.urls import path
from audioprediction import views


urlpatterns = [
    path('hello/', views.hello, name='hello'),
]

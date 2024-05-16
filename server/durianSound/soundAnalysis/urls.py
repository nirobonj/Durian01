from django.urls import path
from . import views

urlpatterns = [
    path('hello/', views.hello, name='hello'),
    # path('upload_file/', views.upload_file, name='upload_file')

]

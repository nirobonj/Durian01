from django.urls import path
from . import views

urlpatterns = [
    path('hello/', views.hello, name='hello'),
    # path('upload_file/', views.upload_file, name='upload_file'),
    # path('upload_file/', views.upload_and_predict, name='upload_and_predict'),
    path('upload_file/', views.upload_and_predict, name='upload_file'),

]

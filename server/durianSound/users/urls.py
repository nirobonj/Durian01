# C:\xampp\htdocs\Durian01\server\durianSound\users\urls.py
from django.urls import path
from .views import UsersViewset
# from .views import register_user

urlpatterns = [
    path('users/', UsersViewset.as_view()),
    path('users/<int:id>', UsersViewset.as_view()),
    path('users/', UsersViewset.as_view(), name='user-create'),
    # path('api/users/', UserCreateAPIView.as_view(), name='user-create'),
    # path('api/users/', register_user, name='register_user'),
    # path('hello/',hello, name = 'hello')
]
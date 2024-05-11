# C:\xampp\htdocs\Durian01\server\durianSound\users\urls.py
from django.urls import path
from .views import UsersViewset,hello,LoginViewset
# from .views import register_user

urlpatterns = [
    path('register/', UsersViewset.as_view()),
    path('register/<int:id>', UsersViewset.as_view()),
    path('register/', UsersViewset.as_view(), name='user-create'),
    path('login/', LoginViewset.as_view()),
    # path('api/users/', UserCreateAPIView.as_view(), name='user-create'),
    # path('api/users/', register_user, name='register_user'),
    path('hello/',hello, name = 'hello')
]
# C:\xampp\htdocs\Durian01\server\durianSound\users\urls.py
from django.urls import path
from .views import UsersViewset, LoginViewset, EditViewset,PromstrListView,ProAumphurDescAPIView
# from .views import register_user

urlpatterns = [
    path('register/', UsersViewset.as_view()),
    path('register/<int:id>', UsersViewset.as_view()),
    path('register/', UsersViewset.as_view(), name='user-create'),
    path('login/', LoginViewset.as_view()),
    path('edit/', EditViewset.as_view()),
    path('edit/<str:username>', EditViewset.as_view(), name='edit_user'),
    path('get-register/', EditViewset.as_view(), name='get_register'),
    path('logout/', LoginViewset.as_view(), name='logout'),
    # path('address/', AddressViewset.as_view()),
    # path('promstr/', PromstrViewset.as_view()),
    path('pro-mstr/', PromstrListView.as_view()),
    path('pro-mstr/aumphur', ProAumphurDescAPIView.as_view()),

]

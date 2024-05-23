from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import AdViewSet
from . import views

router = DefaultRouter()
router.register(r'ads', AdViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('ad/add/', views.add_ad, name='add_ad'),
]

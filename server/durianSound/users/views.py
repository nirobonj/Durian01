# C:\xampp\htdocs\Durian01\server\durianSound\users\views.py
from rest_framework import viewsets
from django.shortcuts import get_object_or_404
from . import models
from . import serializers
from .serializers import RegisterSerializer, LoginSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import JsonResponse
from .models import Register,Login
from rest_framework.decorators import api_view
from django.contrib.auth.hashers import make_password

def hello(request):
    data = {"message": "Hello, Django!"}
    print(request)
    return JsonResponse(data)

class UsersViewset(APIView):
    def get(self, request, id=None):
        if id:
            item = get_object_or_404(models.Register, id=id)
            serializer = serializers.RegisterSerializer(item)
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

        items = models.Register.objects.all()
        serializer = serializers.RegisterSerializer(items, many=True)
        print("a")
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = serializers.RegisterSerializer(data=request.data)
        if serializer.is_valid():
            password = request.data.get('password')
            hashed_password = make_password(password)
            serializer.validated_data['password'] = hashed_password
            serializer.save()
            login_data = {
            'username': request.data.get('username'),  
            'password': hashed_password 
        }
            # login_serializer = LoginSerializer(data=request.data)
            login_serializer = LoginSerializer(data=login_data)
            if login_serializer.is_valid():
                login_serializer.save()
                return Response({"status": "success", "data": serializer.data}, status=status.HTTP_201_CREATED)
            else:
                return Response({"status": "error", "data": login_serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({"status": "error", "data": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
        
    
    def patch(self, request, id=None):
        item = get_object_or_404(models.Register, id=id)
        serializer = serializers.RegisterSerializer(item, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)
        else:
            return Response({"status": "error", "data": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id=None):
        item = get_object_or_404(models.Register, id=id)
        item.delete()
        return Response({"status": "success", "data": "Item Deleted"}, status=status.HTTP_204_NO_CONTENT)

# def hello(request):
#     return JsonResponse({"status": "success"})

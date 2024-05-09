# C:\xampp\htdocs\Durian01\server\durianSound\users\views.py
from rest_framework import viewsets
from django.shortcuts import get_object_or_404
from . import models
from . import serializers
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import JsonResponse
from .models import Users
from rest_framework.decorators import api_view

class UsersViewset(APIView):
    def get(self, request, id=None):
        if id:
            item = get_object_or_404(models.Users, id=id)
            serializer = serializers.UsersSerializer(item)
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

        items = models.Users.objects.all()
        serializer = serializers.UsersSerializer(items, many=True)
        print("a")
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        serializer = serializers.UsersSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            print("b")
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_201_CREATED)
        else:
            return Response({"status": "error", "data": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
# @api_view(['POST'])
# def register_user(request):
#     if request.method == 'POST':
#         data = request.data
#         print("postregister")
        
#         user = Users.objects.create(
#             fname=data.get('fname'),
#             lname=data.get('lname'),
#             tel=data.get('tel'),
#             province=data.get('province'),
#             types=data.get('type'),
#             username=data.get('username'),
#             password=data.get('password'),
#         )
#         return Response(status=status.HTTP_201_CREATED)
#     else:
#         return Response(status=status.HTTP_400_BAD_REQUEST)

def patch(self, request, id=None):
        item = get_object_or_404(models.Users, id=id)
        serializer = serializers.UsersSerializer(item, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)
        else:
            return Response({"status": "error", "data": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

def delete(self, request, id=None):
        item = get_object_or_404(models.Users, id=id)
        item.delete()
        return Response({"status": "success", "data": "Item Deleted"}, status=status.HTTP_204_NO_CONTENT)

# def hello(request):
#     return JsonResponse({"status": "success"})

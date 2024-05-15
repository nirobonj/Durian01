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
from django.contrib.auth.hashers import check_password

def hello(request):
    # data = {"message": "Hello, Django!"}
    data= {"message": "สวัสดี"}
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

class LoginViewset(APIView):
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
        username = request.data.get('username')
        password = request.data.get('password')
        try:
            user = models.Register.objects.get(username=username)
        except models.Register.DoesNotExist:
            return Response({"status": "error", "message": "User not found"}, status=status.HTTP_404_NOT_FOUND)

        if check_password(password, user.password):
            return Response({"status": "success", "message": "Login successful"}, status=status.HTTP_200_OK)
        else:
            return Response({"status": "error", "message": "Invalid username or password"}, status=status.HTTP_401_UNAUTHORIZED)
        
    
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
    


class EditViewset(APIView):    
    def get(self, request, username):
        try:
            print("a")
            user = get_object_or_404(Register, username=username)
            print("b")
        # ค้นพบผู้ใช้ ส่งข้อมูลกลับเป็น JSON
            return JsonResponse({'status': 'success', 'data': {
                'firstname': user.fname,
                'lastname': user.lname,
                'username': user.username,
                'tel': user.tel,
                'province': user.province,
                'types': user.types,
            }})
        except Register.DoesNotExist:
            # ไม่พบผู้ใช้ ส่งข้อความว่า "ไม่พบข้อมูล"
            return JsonResponse({'status': 'error', 'message': 'ไม่พบข้อมูลผู้ใช้'}, status=404)
        except Exception as e:
        # เกิดข้อผิดพลาดอื่น ๆ ส่งข้อความข้อผิดพลาดกลับ
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)


    def post(self, request):
        data = request.data
        username = data.get('username')
       
        try:
            user = models.Register.objects.get(username=username)
            # อัปเดตข้อมูลจาก request.data ที่ส่งเข้ามา
            user.fname = data.get('firstname', user.fname)
            user.lname = data.get('lastname', user.lname)
            user.tel = data.get('tel', user.tel)
            user.province = data.get('province', user.province)
            user.types = data.get('types', user.types)
            user.save()  # บันทึกการเปลี่ยนแปลง

            # พร้อมส่งข้อมูลที่อัปเดตแล้วกลับไปให้แอปพลิเคชัน
            return Response({'message': 'Success', 'data': {
                'firstname': user.fname,
                'lastname': user.lname,
                'username': user.username,
                'tel': user.tel,
                'province': user.province,
                'types': user.types,
            }}, status=status.HTTP_200_OK)
        except models.Register.DoesNotExist:
            return Response({'message': 'Failed', 'data': None}, status=status.HTTP_400_BAD_REQUEST)
        
    def patch(self, request, username):  # เปลี่ยนจาก POST เป็น PUT เพื่อการอัปเดตข้อมูล
        data = request.data
        try:
            user = Register.objects.get(username=username)
            user.fname = data.get('firstname', user.fname)
            user.lname = data.get('lastname', user.lname)
            user.tel = data.get('tel', user.tel)
            user.province = data.get('province', user.province)
            user.types = data.get('types', user.types)
            user.save()  # บันทึกการเปลี่ยนแปลง
            return JsonResponse({'status': 'success', 'message': 'อัปเดตข้อมูลสำเร็จ'})
        except Register.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'ไม่พบข้อมูลผู้ใช้'}, status=404)
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)
    

    # def get_register(request):
    #     if request.method == 'POST':
    #         username = request.data.get('username', None)  # รับค่า username จาก request ในรูปแบบ JSON
    #     # password = request.POST.get('password', None)  # รับค่า password จาก request

    #         if username is not None:
    #         # ค้นหา record ในฐานข้อมูล
    #             register = get_object_or_404(Register, username=username)
    #         # สร้าง dictionary เพื่อเก็บข้อมูลที่จะส่งกลับ
    #             data = {
    #                 'username': register.username,
    #             # สามารถเพิ่ม key-value อื่นๆ ตามต้องการ
    #             }
    #             print('พบ username ที่ตรงกัน: {}'.format(username))  # แสดง username ที่พบใน terminal
    #             return JsonResponse(data)
    #         else:
    #             print('ไม่พบ username ที่ตรงกัน')  # แสดงข้อความ error ใน terminal
    #             return JsonResponse({'error': 'Incomplete data provided'}, status=400)
    #     else:
    #         return JsonResponse({'error': 'Invalid request method'}, status=405)

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
from .models import Register, Login
from rest_framework.decorators import api_view
from django.contrib.auth.hashers import make_password
from django.contrib.auth.hashers import check_password


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
        # Serialize data for registration
        register_serializer = serializers.RegisterSerializer(data=request.data)
        if register_serializer.is_valid():
            # Hash the password
            password = request.data.get('register_password')
            hashed_password = make_password(password)

            # Save data to register table
            register_serializer.validated_data['register_password'] = hashed_password
            register_serializer.save()

            # Prepare data for login table
            login_data = {
                'login_username': request.data.get('register_username'),
                'login_password': hashed_password
            }
            # Serialize data for login
            login_serializer = serializers.LoginSerializer(data=login_data)
            if login_serializer.is_valid():
                # Save data to login table
                login_serializer.save()
                return Response({"status": "success", "data": register_serializer.data}, status=status.HTTP_201_CREATED)
            else:
                return Response({"status": "error", "data": login_serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({"status": "error", "data": register_serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

    # def create_user(request):
    #     if request.method == 'POST':
    #         data = request.data
    #         try:
    #         # ตรวจสอบว่า username ซ้ำหรือไม่
    #             if Register.objects.filter(username=data['username']).exists():
    #                 return Response({'status': 'error', 'message': 'ชื่อผู้ใช้นี้ถูกใช้ไปแล้ว'}, status=status.HTTP_400_BAD_REQUEST)

    #         # หากไม่มีการซ้ำ สร้างผู้ใช้ใหม่
    #             user = Register.objects.create(
    #                 fname=data.get('fname'),
    #                 lname=data.get('lname'),
    #                 tel=data.get('tel'),
    #                 province=data.get('province'),
    #                 types=data.get('types'),
    #                 username=data.get('username'),
    #                 password=data.get('password')
    #             )
    #             return Response({'status': 'success', 'message': 'ลงทะเบียนสำเร็จ'}, status=status.HTTP_201_CREATED)
    #         except IntegrityError:
    #             return Response({'status': 'error', 'message': 'มีข้อผิดพลาดในการสร้างผู้ใช้'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def patch(self, request, id=None):
        item = get_object_or_404(models.Register, id=id)
        serializer = serializers.RegisterSerializer(
            item, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)
        else:
            return Response({"status": "error", "data": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id=None):
        item = get_object_or_404(models.Register, id=id)
        item.delete()
        return Response({"status": "success", "data": "Item Deleted"}, status=status.HTTP_204_NO_CONTENT)


class LoginViewset(APIView):
    def get(self, request, id=None):
        if 'user' in request.session:
            if id:
                item = get_object_or_404(models.Register, id=id)
                serializer = serializers.RegisterSerializer(item)
                return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

            items = models.Register.objects.all()
            serializer = serializers.RegisterSerializer(items, many=True)
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

    def post(self, request, format=None):
        username = request.data.get('login_username')
        password = request.data.get('login_password')
        try:
            user = models.Register.objects.get(register_username=username)
        except models.Register.DoesNotExist:
            return Response({"status": "error", "message": "User not found"}, status=status.HTTP_404_NOT_FOUND)

        if check_password(password, user.register_password):
            request.session['user'] = username
            return Response({"status": "success", "message": "Login successful"}, status=status.HTTP_200_OK)
        else:
            return Response({"status": "error", "message": "Invalid username or password"}, status=status.HTTP_401_UNAUTHORIZED)

    def patch(self, request, id=None):
        if 'user' in request.session:
            item = get_object_or_404(models.Register, id=id)
            serializer = serializers.RegisterSerializer(
                item, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)
            else:
                return Response({"status": "error", "data": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id=None):
        item = get_object_or_404(models.Register, id=id)
        item.delete()
        return Response({"status": "success", "data": "Item Deleted"}, status=status.HTTP_204_NO_CONTENT)

    @api_view(['POST'])
    def logout(request):
        try:
            if 'user' in request.session:
                del request.session['user']
                return Response({"status": "success", "message": "Logout successful"}, status=status.HTTP_200_OK)
            else:
                return Response({"status": "error", "message": "User not logged in"}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({"status": "error", "message": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class EditViewset(APIView):
    def get(self, request, username):
        try:
            user = get_object_or_404(
                models.Register, register_username=username)
            return JsonResponse({'status': 'success', 'data': {
                'firstname': user.register_fname,
                'lastname': user.register_lname,
                'username': user.register_username,
                'tel': user.register_tel,
                'province': user.register_province,
                'types': user.register_types,
            }})
        except models.Register.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'ไม่พบข้อมูลผู้ใช้'}, status=404)
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)}, status=500)

    def post(self, request):
        data = request.data
        username = data.get('username')

        try:
            user = models.Register.objects.get(register_username=username)
            user.register_fname = data.get('firstname', user.register_fname)
            user.register_lname = data.get('lastname', user.register_lname)
            user.register_tel = data.get('tel', user.register_tel)
            user.register_province = data.get(
                'province', user.register_province)
            user.register_types = data.get('types', user.register_types)
            user.save()  # บันทึกการเปลี่ยนแปลง

            return Response({'message': 'Success', 'data': {
                'firstname': user.register_fname,
                'lastname': user.register_lname,
                'username': user.register_username,
                'tel': user.register_tel,
                'province': user.register_province,
                'types': user.register_types,
            }}, status=status.HTTP_200_OK)
        except models.Register.DoesNotExist:
            return Response({'message': 'Failed', 'data': None}, status=status.HTTP_400_BAD_REQUEST)

    def put(self, request, username):
        data = request.data
        try:
            user = models.Register.objects.get(register_username=username)
            user.register_fname = data.get('firstname', user.register_fname)
            user.register_lname = data.get('lastname', user.register_lname)
            user.register_tel = data.get('tel', user.register_tel)
            user.register_province = data.get(
                'province', user.register_province)
            user.register_types = data.get('types', user.register_types)
            user.save()  # บันทึกการเปลี่ยนแปลง
            return JsonResponse({'status': 'success', 'message': 'อัปเดตข้อมูลสำเร็จ'})
        except models.Register.DoesNotExist:
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

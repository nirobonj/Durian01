# C:\xampp\htdocs\Durian01\server\durianSound\users\serializers.py
#แปลงอินพุต json เพื่อให้ django สามารถเข้าใจได้ ใช้เพื่อจัดเก็บในฐานข้อมูลเพื่อใช้รูปแบบที่อ่านได้
from rest_framework import serializers
from .models import Users

class UsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        # field = ('id', 'mobile', 'fullname')
        fields = '__all__'
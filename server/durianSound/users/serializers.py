# C:\xampp\htdocs\Durian01\server\durianSound\users\serializers.py
#แปลงอินพุต json เพื่อให้ django สามารถเข้าใจได้ ใช้เพื่อจัดเก็บในฐานข้อมูลเพื่อใช้รูปแบบที่อ่านได้
from rest_framework import serializers
from .models import Register,Login,Addresses,PRO_MSTR

class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Register
        # field = ('id', 'mobile', 'fullname')
        fields = '__all__'

class LoginSerializer(serializers.ModelSerializer):
    class Meta:
        model = Login
        fields = '__all__'


class AddressesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Addresses
        fields = '__all__'

class PromstrSerializer(serializers.ModelSerializer):
    class Meta:
        model = PRO_MSTR
        fields = '__all__'

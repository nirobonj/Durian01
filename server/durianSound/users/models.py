# C:\xampp\htdocs\Durian01\server\durianSound\users\models.py
from django.db import models

# Create your models here.

class Register(models.Model):
    register_fname = models.CharField(max_length=100)
    register_lname = models.CharField(max_length=100)
    register_username = models.CharField(max_length=100, unique=True)
    register_password = models.CharField(max_length=100)
    register_tel = models.CharField(max_length=10)
    register_province = models.CharField(max_length=100)
    register_types = models.CharField(max_length=100)

class Login(models.Model):
    login_username = models.CharField(max_length=100)
    login_password = models.CharField(max_length=100)




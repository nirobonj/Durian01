# C:\xampp\htdocs\Durian01\server\durianSound\users\models.py
from django.db import models

# Create your models here.

class Register(models.Model):
    fname = models.CharField(max_length=100)
    lname = models.CharField(max_length=100)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    tel = models.CharField(max_length=10)
    province = models.CharField(max_length=100)
    types = models.CharField(max_length=100)

class Login(models.Model):
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)




# C:\xampp\htdocs\Durian01\server\durianSound\users\models.py
# from django.db import models

# # Create your models here.


# class Register(models.Model):
#     register_fname = models.CharField(max_length=100)
#     register_lname = models.CharField(max_length=100)
#     register_username = models.CharField(max_length=100, unique=True)
#     register_password = models.CharField(max_length=100)
#     register_tel = models.CharField(max_length=10)
#     register_province = models.CharField(
#         max_length=100, default='กรุงเทพมหานคร')
#     register_types = models.CharField(max_length=100)


# class Login(models.Model):
#     login_username = models.CharField(max_length=100)
#     login_password = models.CharField(max_length=100)


# class PRO_MSTR(models.Model):
#     pro_province_code = models.CharField(max_length=50)
#     pro_province_desc = models.CharField(max_length=100)
#     pro_tumbol_code = models.CharField(max_length=50)
#     pro_tumbol_desc = models.CharField(max_length=100)
#     pro_aumphur_code = models.CharField(max_length=50)
#     pro_aumphur_desc = models.CharField(max_length=100)
#     pro_code = models.CharField(max_length=30)
#     pro_country = models.CharField(max_length=50,default='TH')
    

# class Addresses(models.Model):
#     add_user = models.CharField(max_length=50)
#     add_province_desc = models.CharField(
#         max_length=100, default='กรุงเทพมหานคร', null=True, blank=True)
#     add_tumbol_desc = models.CharField(max_length=100, null=True, blank=True)
#     add_aumphur_desc = models.CharField(max_length=100, null=True, blank=True)
#     add_code = models.CharField(max_length=30, null=True, blank=True)

from django.db import models


class Register(models.Model):
    register_fname = models.CharField(max_length=100)
    register_lname = models.CharField(max_length=100)
    register_username = models.CharField(max_length=100, unique=True)
    register_password = models.CharField(max_length=100)
    register_tel = models.CharField(max_length=10)
    pro_tumbol_desc = models.CharField(max_length=100, null=True, blank=True)
    pro_aumphur_desc = models.CharField(max_length=100, null=True, blank=True)
    register_province = models.CharField(max_length=100,default='กรุงเทพมหานคร')
    register_types = models.CharField(max_length=100)



class Login(models.Model):
    login_username = models.CharField(max_length=100)
    login_password = models.CharField(max_length=100)

class PRO_MSTR(models.Model):
    pro_province_code = models.CharField(max_length=50)
    pro_province_desc = models.CharField(max_length=100)
    pro_tumbol_code = models.CharField(max_length=50)
    pro_tumbol_desc = models.CharField(max_length=100)
    pro_aumphur_code = models.CharField(max_length=50)
    pro_aumphur_desc = models.CharField(max_length=100)
    pro_code = models.CharField(max_length=30)
    # pro_country = models.CharField(max_length=50,default='TH')


class Addresses(models.Model):
    add_user = models.CharField(max_length=50)
    add_province_desc = models.CharField(max_length=100, default='กรุงเทพมหานคร', null=True, blank=True)
    add_tumbol_desc = models.CharField(max_length=100, null=True, blank=True)
    add_aumphur_desc = models.CharField(max_length=100, null=True, blank=True)
    add_code = models.CharField(max_length=30, null=True, blank=True)
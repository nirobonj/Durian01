# Generated by Django 5.0.6 on 2024-05-24 02:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0007_rename_password_login_login_password_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='pro_mstr',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('pro_province_code', models.CharField(max_length=50)),
                ('pro_province_desc', models.CharField(max_length=100)),
                ('pro_tumbol_code', models.CharField(max_length=50)),
                ('pro_tumbol_desc', models.CharField(max_length=100)),
                ('pro_aumphur_code', models.CharField(max_length=50)),
                ('pro_aumphur_desc', models.CharField(max_length=100)),
                ('pro_code', models.CharField(max_length=30)),
                ('pro_ctry_code', models.CharField(max_length=80)),
            ],
        ),
    ]
# Generated by Django 5.0.6 on 2024-05-15 09:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0005_login'),
    ]

    operations = [
        migrations.AlterField(
            model_name='register',
            name='username',
            field=models.CharField(max_length=100, unique=True),
        ),
    ]

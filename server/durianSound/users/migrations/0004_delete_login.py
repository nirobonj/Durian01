# Generated by Django 5.0.6 on 2024-05-10 09:15

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0003_rename_users_register'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Login',
        ),
    ]

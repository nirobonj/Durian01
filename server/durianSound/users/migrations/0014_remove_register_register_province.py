# Generated by Django 5.0.6 on 2024-05-24 04:18

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0013_remove_addresses_add_aumphur_code_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='register',
            name='register_province',
        ),
    ]
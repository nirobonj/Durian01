# Generated by Django 5.0.6 on 2024-05-20 07:09

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ads', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='ad',
            name='image_url',
        ),
        migrations.AddField(
            model_name='ad',
            name='image',
            field=models.ImageField(default=datetime.datetime(2024, 5, 20, 7, 9, 18, 137579, tzinfo=datetime.timezone.utc), max_length=200, upload_to=''),
            preserve_default=False,
        ),
    ]

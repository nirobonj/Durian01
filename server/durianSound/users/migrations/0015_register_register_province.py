# Generated by Django 5.0.6 on 2024-05-24 04:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0014_remove_register_register_province'),
    ]

    operations = [
        migrations.AddField(
            model_name='register',
            name='register_province',
            field=models.CharField(default='กรุงเทพมหานคร', max_length=100),
        ),
    ]

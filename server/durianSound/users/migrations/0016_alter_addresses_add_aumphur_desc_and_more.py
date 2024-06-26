# Generated by Django 5.0.6 on 2024-05-24 07:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0015_register_register_province'),
    ]

    operations = [
        migrations.AlterField(
            model_name='addresses',
            name='add_aumphur_desc',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='addresses',
            name='add_code',
            field=models.CharField(blank=True, max_length=30, null=True),
        ),
        migrations.AlterField(
            model_name='addresses',
            name='add_province_desc',
            field=models.CharField(blank=True, default='กรุงเทพมหานคร', max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='addresses',
            name='add_tumbol_desc',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]

# Generated by Django 5.0.6 on 2024-05-24 02:50

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0009_rename_pro_aumphur_code_pro_mstr_pro_amphur_code_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='pro_mstr',
            old_name='pro_amphur_code',
            new_name='pro_aumphur_code',
        ),
        migrations.RenameField(
            model_name='pro_mstr',
            old_name='pro_amphur_desc',
            new_name='pro_aumphur_desc',
        ),
    ]
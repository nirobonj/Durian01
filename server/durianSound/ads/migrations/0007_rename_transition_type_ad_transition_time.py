# Generated by Django 5.0.6 on 2024-05-20 08:42

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ads', '0006_remove_ad_display_duration_end_date'),
    ]

    operations = [
        migrations.RenameField(
            model_name='ad',
            old_name='transition_type',
            new_name='transition_time',
        ),
    ]

from django import forms
from .models import Ad

class AdForm(forms.ModelForm):
    class Meta:
        model = Ad
        fields = ['image_url', 'link_url', 'display_duration', 'transition_time']

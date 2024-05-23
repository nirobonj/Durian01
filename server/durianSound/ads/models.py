from django.db import models
class Ad(models.Model):
    image_url = models.URLField(max_length=1000)
    # image = models.ImageField(max_length=200)
    link_url = models.URLField(max_length=1000)
    display_duration = models.DateField()  # in seconds
    # display_duration_end_date = models.DateField()
    transition_time = models.IntegerField()

    def __str__(self):
        return f"Ad {self.id}: {self.image_url}"


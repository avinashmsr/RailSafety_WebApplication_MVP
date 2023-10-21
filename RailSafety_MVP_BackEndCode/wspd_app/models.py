from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class Train(models.Model):
    train_no = models.IntegerField(primary_key=True)
    train_name = models.CharField(max_length=264)
    description = models.CharField(max_length=264)


class Rake(models.Model):
    train = models.ForeignKey(Train, related_name='rakes', on_delete=models.CASCADE)
    rake_no = models.CharField(primary_key=True, max_length=50)
    description = models.CharField(max_length=264)
    status = models.CharField(max_length=20)


class Coach(models.Model):
    coach_no = models.CharField(primary_key=True, max_length=50)
    coach_type = models.CharField(max_length=264)
    coach_class = models.CharField(max_length=264)
    description = models.CharField(max_length=264)
    rake = models.ForeignKey(Rake, related_name='coaches', on_delete=models.CASCADE)
    position = models.IntegerField(default=0)
    coach_name = models.CharField(max_length=264,default='')


# class RakeCoach(models.Model):
#     rake = models.ForeignKey(Rake, on_delete=models.CASCADE)
#     coach = models.ForeignKey(Coach, on_delete=models.CASCADE)
#     position = models.IntegerField()
#     coach_name = models.CharField(max_length=264)


class FaultTable(models.Model):
    wsp_status_code = models.IntegerField(default=0)
    fault_datetime = models.DateTimeField()
    coach = models.ForeignKey(Coach, related_name='faults', on_delete=models.CASCADE)

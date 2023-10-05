from django.conf.urls import url

from .views import *

urlpatterns = [
    url(r'^getTrainList/$', TrainList.as_view()),
    #url(r'^rakesListForTrain/(?P<pk>\d+)/$', RakesListForTrain.as_view()),
    url(r'^getSummary/$', GetSummary.as_view()),
    url(r'^updateCoachDetails/(?P<pk>\w+)/$', UpdateCoachDetails.as_view()),
    url(r'^addCoachDetails/$', AddCoachDetails.as_view()),
    url(r'^getCoachDetails/(?P<pk>\w+)/$', GetCoachDetails.as_view()),
    url(r'^updateRakeDetails/(?P<pk>\w+)/$', UpdateRakeDetails.as_view()),
    url(r'^addRakeDetails/$', AddRakeDetails.as_view()),
    url(r'^getRakeDetails/(?P<pk>\w+)/$', GetRakeDetails.as_view()),
    url(r'^updateTrainDetails/(?P<pk>\w+)/$', UpdateTrainDetails.as_view()),
    url(r'^addTrainDetails/$', AddTrainDetails.as_view()),
    url(r'^getTrainDetails/(?P<pk>\w+)/$', GetTrainDetails.as_view()),
    url(r'^getCoachFaults/(?P<pk>\w+)/$', GetCoachFaults.as_view()),
    url(r'^getCoachList/$', GetCoachList.as_view()),
    url(r'^getRakeList/$', GetRakeList.as_view()),
    url(r'^deleteCoachDetails/(?P<pk>\w+)/$', DeleteCoachDetails.as_view()),
    url(r'^deleteRakeDetails/(?P<pk>\w+)/$', DeleteRakeDetails.as_view()),
    url(r'^deleteTrainDetails/(?P<pk>\w+)/$', DeleteTrainDetails.as_view()),
]

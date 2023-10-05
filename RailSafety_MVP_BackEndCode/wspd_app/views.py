from rest_framework import generics, permissions

from .models import Train, Rake, Coach, FaultTable
from .serializers import TrainSerializer, TrainSerializer2, RakeSerializer, RakeSerializer2, CoachSerializer, CoachSerializer2, FaultTableSerializer


class TrainList(generics.ListAPIView):
    """ View for list of Trains"""
    queryset = Train.objects.all()
    serializer_class = TrainSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class RakesListForTrain(generics.RetrieveAPIView):
    """ View  for list of Rakes for a Train"""
    queryset = Train.objects.all()
    serializer_class = TrainSerializer
    permission_classes = (permissions.IsAuthenticated,)

class GetSummary(generics.ListAPIView):
    """ View for list of Trains"""
    queryset = Train.objects.all()
    serializer_class = TrainSerializer
    permission_classes = (permissions.IsAuthenticated,)


class UpdateCoachDetails(generics.UpdateAPIView):

    queryset = Coach.objects.all()
    serializer_class = CoachSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class AddCoachDetails(generics.CreateAPIView):

    queryset = Coach.objects.all()
    serializer_class = CoachSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class GetCoachDetails(generics.RetrieveAPIView):
    """ """
    queryset = Coach.objects.all()
    serializer_class = CoachSerializer2
    permission_classes = (permissions.IsAuthenticated,)

class DeleteCoachDetails(generics.DestroyAPIView):
    """ """
    queryset = Coach.objects.all()
    serializer_class = CoachSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class UpdateRakeDetails(generics.UpdateAPIView):

    queryset = Rake.objects.all()
    serializer_class = RakeSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class AddRakeDetails(generics.CreateAPIView):

    queryset = Rake.objects.all()
    serializer_class = RakeSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class GetRakeDetails(generics.RetrieveAPIView):
    """ """
    queryset = Rake.objects.all()
    serializer_class = RakeSerializer2
    permission_classes = (permissions.IsAuthenticated,)

class DeleteRakeDetails(generics.DestroyAPIView):
    """ """
    queryset = Rake.objects.all()
    serializer_class = RakeSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class UpdateTrainDetails(generics.UpdateAPIView):

    queryset = Train.objects.all()
    serializer_class = TrainSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class AddTrainDetails(generics.CreateAPIView):

    queryset = Train.objects.all()
    serializer_class = TrainSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class GetTrainDetails(generics.RetrieveAPIView):
    """ """
    queryset = Train.objects.all()
    serializer_class = TrainSerializer2
    permission_classes = (permissions.IsAuthenticated,)

class DeleteTrainDetails(generics.DestroyAPIView):
    """ """
    queryset = Train.objects.all()
    serializer_class = TrainSerializer2
    permission_classes = (permissions.IsAuthenticated,)


class GetCoachFaults(generics.RetrieveAPIView):
    """ """
    queryset = Coach.objects.all()
    serializer_class = CoachSerializer
    permission_classes = (permissions.IsAuthenticated,)


class GetCoachList(generics.ListAPIView):
    """ """
    serializer_class = CoachSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_queryset(self):
        queryset = Coach.objects.all()
        
        trainrake_no = self.request.query_params.get('trainrake_no', None)
        if trainrake_no is not None:
            queryset = queryset.filter(rake__trainrake_no=trainrake_no)
        return queryset

class GetRakeList(generics.ListAPIView):
    """ """
    serializer_class = RakeSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_queryset(self):
        queryset = Rake.objects.all()
        
        train_no = self.request.query_params.get('train_no', None)
        if train_no is not None:
            queryset = queryset.filter(train__train_no=train_no)
        return queryset

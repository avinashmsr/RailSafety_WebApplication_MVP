from rest_framework import serializers

from .models import Train, Rake, Coach, FaultTable


class FaultTableSerializer(serializers.ModelSerializer):

    class Meta:
        model = FaultTable
        fields = '__all__'

class CoachSerializer(serializers.ModelSerializer):
    faults = FaultTableSerializer(many=True)

    class Meta:
        model = Coach
        fields = '__all__'


class CoachSerializer2(serializers.ModelSerializer):

    class Meta:
        model = Coach
        fields = '__all__'

class CoachSerializer3(serializers.ModelSerializer):
    faults = FaultTableSerializer(many=True)

    class Meta:
        model = Coach
        fields = ('coach_no','faults')
        
class RakeSerializer(serializers.ModelSerializer):
    coaches = CoachSerializer3(many=True)

    class Meta:
        model = Rake
        fields = ('trainrake_no','rake_no','train','coaches')


class RakeSerializer2(serializers.ModelSerializer):

    class Meta:
        model = Rake
        fields = '__all__'


class TrainSerializer(serializers.ModelSerializer):
    rakes = RakeSerializer(many=True)

    class Meta:
        model = Train
        fields = ('train_no','rakes')


class TrainSerializer2(serializers.ModelSerializer):

    class Meta:
        model = Train
        fields = '__all__'




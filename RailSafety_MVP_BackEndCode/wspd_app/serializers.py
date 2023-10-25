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
        
class RakeSerializer(serializers.ModelSerializer):
    coaches = CoachSerializer(many=True)

    class Meta:
        model = Rake
        fields = '__all__'

class RakeSerializer2(serializers.ModelSerializer):

    class Meta:
        model = Rake
        fields = '__all__'

class TrainSerializer(serializers.ModelSerializer):
    rakes = RakeSerializer(many=True)
    train_level_faults = FaultTableSerializer(many=True)

    class Meta:
        model = Train
        fields = '__all__'

class TrainSerializer2(serializers.ModelSerializer):

    class Meta:
        model = Train
        fields = '__all__'



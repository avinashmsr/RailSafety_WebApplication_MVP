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
        
class RakeSerializer(serializers.ModelSerializer):
    coaches = CoachSerializer(many=True)

    class Meta:
        model = Rake
        fields = '__all__'


class TrainSerializer(serializers.ModelSerializer):
    rakes = RakeSerializer(many=True)

    class Meta:
        model = Train
        fields = '__all__'




# class RakeCoachListSerializer(serializers.ModelSerializer):
#     #rake_obj = RakeSerializer(many=True)
#     #coach_obj = CoachSerializer(many=True)

#     class Meta:
#         model = RakeCoach
#         fields = '__all__'

# class RakeCoachDetailSerializer(serializers.ModelSerializer):
#     #rake_obj = RakeSerializer(many=True)
#     #coach_obj = CoachSerializer(many=True)

#     class Meta:
#         model = RakeCoach
#         fields = '__all__'
#         depth = 1




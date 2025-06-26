from rest_framework import serializers
from .models import Parceiro

class ParceiroSerializer(serializers.ModelSerializer):
    class Meta:
        model = Parceiro    #modelos a serem serializados
        fields = '__all__'  #campos
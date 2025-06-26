from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from django.contrib.gis.geos import Point
from django.contrib.gis.db.models.functions import Distance
from django.db.models.functions import Cast
from django.db.models import CharField
from django.db import models

from .models import Parceiro
from .serializers import ParceiroSerializer

import json

@api_view(['GET'])
def get_parceiros(request):
    if request.method == 'GET':
        parceiros = Parceiro.objects.all()
        serializer = ParceiroSerializer(parceiros, many=True)
        return Response(serializer.data)
    return Response(status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_by_id(request, id):
    try: parceiro = Parceiro.objects.get(pk = id)
    except: return Response(status=status.HTTP_404_NOT_FOUND)
    
    if request.method == 'GET': 
        serializer = ParceiroSerializer(parceiro)
        return Response(serializer.data)
    
@api_view(['POST'])
def criar_parceiro(request):
    if request.method == 'POST':
        new_partner = request.data
        serializer = ParceiroSerializer(data=new_partner)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def search_parceiro(request):
        if request.method == 'GET':
            try:
                longitude = float(request.query_params.get('long'))
                latitude = float(request.query_params.get('lat'))
            except (TypeError, ValueError):
                return Response(status=status.HTTP_400_BAD_REQUEST)

            local = Point(longitude, latitude, srid=4326)

            parceirosProximos = Parceiro.objects.filter(coverageArea__contains=local)

            if not parceirosProximos.exists():
                return Response(status=status.HTTP_404_NOT_FOUND)

            maisProximo = parceirosProximos.annotate(
                distance=models.functions.Cast(
                    Distance('address', local),
                    output_field=CharField()
                )
            ).order_by('distance').first()

            if maisProximo:
                serializer = ParceiroSerializer(maisProximo)
                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)



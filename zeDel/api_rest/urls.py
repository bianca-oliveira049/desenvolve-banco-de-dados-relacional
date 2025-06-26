from django.contrib import admin
from django.urls import path, include

from . import views

urlpatterns = [
    path('', views.get_parceiros, name='gett_all_partners'),
    path('parceiro/<int:id>', views.get_by_id),
    path('parceiro/buscar/', views.search_parceiro, name='parceiro-buscar'),
    path('parceiro/criar', views.criar_parceiro, name='parceiro-criar'),
]
from django.contrib.gis.db import models

class Parceiro(models.Model):
    id = models.AutoField(primary_key=True)
    tradingName = models.CharField(max_length=255)
    ownerName = models.CharField(max_length=255)
    document = models.CharField(max_length=18, unique=True)
    coverageArea = models.MultiPolygonField(srid=4326)
    address = models.PointField(srid=4326)

    def __str__(self):
        return f"Trading Name: {self.tradingName} | Document: {self.document}"
    
    def clean(self):
        if self.address:
            lon = self.address.x
            lat = self.address.y
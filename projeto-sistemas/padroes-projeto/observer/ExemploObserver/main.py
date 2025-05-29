# main.py

import time
import random
from sensor_data import SensorData
from dashboards import GraficoTemperatura, ResumoClimatico, AlertaAltaTemperatura

sensor = SensorData()

# Instancia os dashboards
grafico = GraficoTemperatura()
resumo = ResumoClimatico()
alerta = AlertaAltaTemperatura()

# Registra os observers
sensor.adicionar_observer(grafico)
sensor.adicionar_observer(resumo)
sensor.adicionar_observer(alerta)

# Simula mudanças nos dados
for _ in range(5):
    temperatura = random.randint(20, 40)
    umidade = random.randint(30, 90)
    sensor.set_dados(temperatura, umidade)
    time.sleep(2)

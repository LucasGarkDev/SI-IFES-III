# dashboards.py

from sensor_data import Observer

class GraficoTemperatura(Observer):
    def update(self, temperatura, umidade):
        print(f"[GRÁFICO] Temperatura atual: {'█' * int(temperatura)} ({temperatura}°C)")

class ResumoClimatico(Observer):
    def update(self, temperatura, umidade):
        print(f"[RESUMO] Temp: {temperatura}°C | Umidade: {umidade}%")

class AlertaAltaTemperatura(Observer):
    def update(self, temperatura, umidade):
        if temperatura >= 30:
            print("[ALERTA] 🌡️ Temperatura ALTA! Atenção!")
        else:
            print("[ALERTA] Temperatura em nível seguro.")

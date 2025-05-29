# sensor_data.py

class Observer:
    def update(self, temperatura, umidade):
        raise NotImplementedError("Subclasse deve implementar update().")

class SensorData:
    def __init__(self):
        self.observers = []
        self.temperatura = 0
        self.umidade = 0

    def adicionar_observer(self, observer):
        self.observers.append(observer)

    def remover_observer(self, observer):
        self.observers.remove(observer)

    def notificar_observers(self):
        for obs in self.observers:
            obs.update(self.temperatura, self.umidade)

    def set_dados(self, temperatura, umidade):
        print(f"\n[SENSOR] Novos dados -> Temp: {temperatura}°C, Umidade: {umidade}%")
        self.temperatura = temperatura
        self.umidade = umidade
        self.notificar_observers()

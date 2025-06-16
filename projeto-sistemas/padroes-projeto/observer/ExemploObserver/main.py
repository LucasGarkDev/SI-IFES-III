import tkinter as tk
from subject import Subject
from data.simulate_data import simular_dados
from utils.logger import Logger
from gui.dashboard import TextWidget, GraphWidget, StatusWidget

# ConcreteSubject com estado real
class SensorData(Subject):
    def __init__(self):
        super().__init__()
        self._valor = 0

    def set_data(self, valor):
        self._valor = valor
        print(f"[Sensor] Novo valor: {valor}")
        self.notify(valor)

# Interface principal
def main():
    sensor = SensorData()
    root = tk.Tk()
    root.title("Observer - Painel Completo")

    # Criação dos observers visuais
    text_widget = TextWidget(root)
    graph_widget = GraphWidget(root)
    status_widget = StatusWidget(root)  # ← novo

    # Registrando os observers no subject
    sensor.attach(text_widget)
    sensor.attach(graph_widget)
    sensor.attach(status_widget)

    # (Opcional)
    sensor.attach(Logger())

    simular_dados(sensor)

    root.mainloop()

if __name__ == "__main__":
    main()

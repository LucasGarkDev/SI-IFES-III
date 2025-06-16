import tkinter as tk
from subject import Subject
from data.simulate_data import simular_dados
from utils.logger import Logger
from gui.dashboard import GraphWidget, TextWidget, StatusWidget, BarWidget

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
    root.title("Dashboard Observer")

    dashboard_frame = tk.Frame(root)
    dashboard_frame.pack()

    graph = GraphWidget(dashboard_frame)
    bar = BarWidget(dashboard_frame)
    text = TextWidget(dashboard_frame)
    status = StatusWidget(dashboard_frame)

    sensor.attach(graph)
    sensor.attach(bar)
    sensor.attach(text)
    sensor.attach(status)

    simular_dados(sensor)
    root.mainloop()


if __name__ == "__main__":
    main()

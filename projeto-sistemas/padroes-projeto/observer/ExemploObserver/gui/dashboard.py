import tkinter as tk
from observer import Observer

class TextWidget(Observer):
    def __init__(self, parent):
        self.label = tk.Label(parent, text="Valor atual: --", font=("Arial", 14))
        self.label.pack(pady=10)

    def update(self, data):
        self.label.config(text=f"Valor atual: {data}")

class GraphWidget(Observer):
    def __init__(self, parent):
        self.canvas = tk.Canvas(parent, width=200, height=100, bg="white")
        self.canvas.pack(pady=10)
        self.rect = self.canvas.create_rectangle(10, 90, 190, 90, fill="blue")

    def update(self, data):
        altura = max(10, min(90, data))
        self.canvas.coords(self.rect, 10, 100 - altura, 190, 90)


class StatusWidget(Observer):
    def __init__(self, parent):
        self.label = tk.Label(parent, text="Status: --", font=("Arial", 14), bg="gray", width=20)
        self.label.pack(pady=10)

    def update(self, data):
        if data < 30:
            self.label.config(text="Status: Baixo ❄️", bg="lightblue")
        elif data < 60:
            self.label.config(text="Status: Médio 🌤️", bg="lightyellow")
        else:
            self.label.config(text="Status: Alto 🔥", bg="lightcoral")
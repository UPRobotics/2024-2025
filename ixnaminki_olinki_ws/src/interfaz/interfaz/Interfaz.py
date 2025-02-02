from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine 
from PyQt5.QtCore import QObject , pyqtSignal , QTimer
from PyQt5.QtCore import pyqtSlot
from datetime import datetime
import sys
import os 
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from io import StringIO

from formatos.srv import Moverob
import rclpy
from rclpy.node import Node

class SetInterfaz(Node):

    def __init__(self):
        super().__init__('set_interfaz_client')
        self.cli = self.create_client(Moverob, 'move_robot')
        while not self.cli.wait_for_service(timeout_sec=1.0):
            self.get_logger().info('service not available, waiting again...')
        self.req = Moverob.Request()

    def send_request(self, a, b):
        self.req.d1 = a
        self.req.d2 = b
        self.req.flipper = 0
        return self.cli.call_async(self.req)

# Backend

class Backend(QObject):
    
    # Funciones
    @pyqtSlot()
    def switchOn(self):
        print("robot on")
        interfaz_client_ = SetInterfaz()
        res = interfaz_client_.send_request(1, 0, 0)
        rclpy.spin_until_future_complete(interfaz_client_, res)
        response = res.result()
        interfaz_client_.get_logger().info(
            'SUCES: %d' %
            (response.success))

        interfaz_client_.destroy_node()        


    @pyqtSlot(str)
    def rightBand(self):
        print("Right")

    @pyqtSlot(str)
    def leftBand(self):
        print("left")

    @pyqtSlot(str)
    def frontFlipper(self):
        print("front")

    @pyqtSlot(str)
    def backFlipper(self):
        print("back")


    @pyqtSlot(int, int, int)
    def getSlidersValues(self, value1, value2, value3):
        print(f"X Value: {value1}")
        print(f"Y Value: {value2}")
        print(f"Z Value: {value3}")

    @pyqtSlot()
    def moveFront1(self):
        print("Moving Forward")

    @pyqtSlot()
    def moveFront2(self):
        print("Moving Forward")

    @pyqtSlot()
    def moveBack1(self):
        print("Going Back")

    @pyqtSlot()
    def moveBack2(self):
        print("Going Back")

    @pyqtSlot()
    def moveRight(self):
        print("Rigth")
    
    @pyqtSlot()
    def moveLeft(self):
        print("Left")

def create_pdf(log_path, terminal_output):
    c = canvas.Canvas(log_path, pagesize=letter)
    width, height = letter

    # Agregar contenido al PDF
    c.setFont("Helvetica", 12)
    c.drawString(100, height - 100, "Mission Log")
    c.drawString(100, height - 120, f"Date: {datetime.now()}")

    # Escribir el contenido de la terminal en el PDF
    y_position = height - 140  # Posición inicial para el texto de la terminal
    for line in terminal_output.getvalue().splitlines():
        c.drawString(100, y_position, line)
        y_position -= 20  # Mover hacia abajo para la siguiente línea
        if y_position < 50:  # Si se llega al final de la página, crear una nueva
            c.showPage()
            y_position = height - 50

    # Guardar el PDF
    c.save()

class TerminalToPDF:
    def __init__(self, terminal_output, original_stdout):
        self.terminal_output = terminal_output
        self.original_stdout = original_stdout

    def write(self, message):
        self.terminal_output.write(message)  # Capturar en el buffer
        self.original_stdout.write(message)  # Imprimir en la terminal

    def flush(self):
        pass

def main():
    app = QApplication(sys.argv)

    # ROS2
    rclpy.init()

    # Crear el motor para cargar el archivo QML
    engine = QQmlApplicationEngine()

    # Cargar el archivo QML
    engine.load("/home/bruno_rb/ixnaminki_olinki_ws/src/interfaz/interfaz/Content/Home.qml")

    # Comprobar si se ha cargado correctamente el archivo QML
    if not engine.rootObjects():
        print("Error: No se cargaron objetos raíz.")
        sys.exit(-1)
    else:
        print("Archivo QML cargado correctamente.")

    # Crear la carpeta si no existe
    ruta_carpeta = "/home/bruno_rb/ixnaminki_olinki_ws/src/interfaz/interfaz/register"
    os.makedirs(ruta_carpeta, exist_ok=True)

    # Redirigir la salida de la terminal
    terminal_output = StringIO()  # Buffer para capturar la salida
    original_stdout = sys.stdout  # Guardar la salida original
    sys.stdout = TerminalToPDF(terminal_output, original_stdout)  # Redirigir la salida

    # Conectar el backend
    backend = Backend()
    engine.rootContext().setContextProperty("pyInterface", backend)

    # Ejecutar la aplicación
    app_exec = app.exec_()

    # Restaurar la salida original
    sys.stdout = original_stdout

    # Obtener la fecha y hora actual para el nombre del archivo
    fecha_hora_actual = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")  # Formato: YYYY-MM-DD_HH-MM-SS
    nombre_archivo = f"bitacora_{fecha_hora_actual}.pdf"
    ruta_log = os.path.join(ruta_carpeta, nombre_archivo)

    # Crear el archivo PDF con el contenido de la terminal
    try:
        create_pdf(ruta_log, terminal_output)
        print(f"PDF guardado en {ruta_log}")
    except Exception as e:
        print(f"Error al guardar el PDF: {e}")

    # Cerrar el buffer
    terminal_output.close()

    # Salir de la aplicación
    sys.exit(app_exec)

if __name__ == "__main__":
    main()
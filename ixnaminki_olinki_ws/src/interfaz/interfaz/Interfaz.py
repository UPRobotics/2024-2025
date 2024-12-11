from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine 
from PyQt5.QtCore import QObject , pyqtSignal , QTimer
from PyQt5.QtCore import pyqtSlot
import sys
import random


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






def main():
        
        app = QApplication(sys.argv)

        #ROS2
        rclpy.init()

        # Crear el motor para cargar el archivo QML
        engine = QQmlApplicationEngine()

        # Cargar el archivo QML
        engine.load("/home/bruno_rb/ixnaminki_olinki_ws/src/interfaz/interfaz/Content/Movimiento.qml")

        # Comprobar si se ha cargado correctamente el archivo QML
        if not engine.rootObjects():
            print("Error: No se cargaron objetos raíz.")
            sys.exit(-1)
        else:
            print("Archivo QML cargado correctamente.")
        
        # Conectar el backend
        backend = Backend()
        engine.rootContext().setContextProperty("pyInterface", backend)
        # Ejecutar la aplicación
        sys.exit(app.exec_())
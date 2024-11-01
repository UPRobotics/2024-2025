from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine 
from PyQt5.QtCore import QObject , pyqtSignal , QTimer
from PyQt5.QtCore import pyqtSlot
import sys
import random

# Backend
class Backend(QObject):

    def __init__(self):
        super().__init__()
        self.timerv = QTimer(self)  # Create voltage timer
        self.timerv.timeout.connect(self.showVoltage)  
        self.timera = QTimer(self)  # Create amperage timer
        self.timera.timeout.connect(self.showAmperage) 
        self.timerc = QTimer(self)  # Create Co2 timer
        self.timerc.timeout.connect(self.showCo)  
        self.timerb = QTimer(self)  # Create amperage timer
        self.timerb.timeout.connect(self.showBattery)  

        self.newvoltage = []


    actualizedVoltage = pyqtSignal(str)
    actualizedAmperage = pyqtSignal(str)
    actualizedCo = pyqtSignal(str)
    actualizedBattery = pyqtSignal(str)
    
    # Funciones
    @pyqtSlot()
    def switchOn(self):
        print("robot on")


    @pyqtSlot()
    def switchOff(self):
        print("Robot Off")

    @pyqtSlot(int, int, int)
    def getSlidersValues(self, value1, value2, value3):
        print(f"X Value: {value1}")
        print(f"Y Value: {value2}")
        print(f"Z Value: {value3}")

    @pyqtSlot()
    def showVoltage(self):
        self.timerv.start(1000)
        newVoltage = random.randint(1,100)
        newVoltage = str(newVoltage)
        self.timera.stop()
        self.timerc.stop()
        self.timerb.stop()

        self.actualizedVoltage.emit(newVoltage)

    @pyqtSlot()
    def showAmperage(self):
        self.timera.start(1000)
        newAmperage= random.randint(1,100)
        newAmperage = str(newAmperage)
        self.timerv.stop()
        self.timerc.stop()
        self.timerb.stop()

        self.actualizedAmperage.emit(newAmperage)

    @pyqtSlot()
    def showCo(self):
        self.timerc.start(1000)
        newCo= random.randint(1,100)
        newCo = str(newCo)
        self.timerv.stop()
        self.timera.stop()
        self.timerb.stop()

        self.actualizedCo.emit(newCo)

        
    @pyqtSlot()
    def showBattery(self):
        self.timerb.start(1000)
        newBattery= random.randint(1,100)
        newBattery = str(newBattery)
        self.timerv.stop()
        self.timera.stop()
        self.timerc.stop()

        self.actualizedBattery.emit(newBattery)



    
if __name__ == "__main__":
    app = QApplication(sys.argv)

    # Crear el motor para cargar el archivo QML
    engine = QQmlApplicationEngine()

    # Cargar el archivo QML
    engine.load("/home/bruno_rb/Interfaz/Content/Home.qml")

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
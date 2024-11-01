from tkinter import *
import os
import subprocess
import threading
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray

# Inicializamos la interfaz de Tkinter
GUI1 = Tk()
GUI1.title("GUI1")
GUI1.geometry("700x500")
GUI1.resizable(False, False)

Titulo = Label(GUI1, text="Lectura de sensores")
Titulo.pack()

armi = [0] * 6  # Arreglo global para guardar los datos recibidos

# Nodo Suscriptor de ROS 2
class EjesSubscriber(Node):
    def __init__(self):
        super().__init__('ejes_subscriber')
        print("f")
        self.subscription = self.create_subscription(
            Float32MultiArray,
            'cambio_ejes_topic',
            self.listener_callback,
            10)
        self.subscription  # Evitar advertencias de variable no utilizada

    def listener_callback(self, msg):
        global armi
        self.get_logger().info(f'Received data: {msg.data}')
        armi = msg.data
        update_interface(armi)

# Función para actualizar la interfaz con los nuevos datos
def update_interface(data):
    global label_var
    label_var.set("{:.2f}".format(data[0])+"° "+"{:.2f}".format(data[1])+"° "+"{:.2f}".format(data[2])+"° "+"{:.2f}".format(data[3])+"° "+"{:.2f}".format(data[4])+"° "+"{:.2f}".format(data[5])+"° ")

# Función para inicializar el nodo ROS 2 en un hilo separado
def ros_spin(node):
    rclpy.spin(node)

# Función para inicializar ROS 2 y el nodo suscriptor
def initialize_ros():
    rclpy.init()
    ejes_subscriber = EjesSubscriber()
    ros_thread = threading.Thread(target=ros_spin, args=(ejes_subscriber,))
    ros_thread.start()
    return ejes_subscriber, ros_thread

# Llamada a la inicialización de ROS 2
ejes_subscriber, ros_thread = initialize_ros()

# Definir los elementos de la interfaz
label_var = StringVar()
label = Label(GUI1, textvariable=label_var)
label.place(x = 10, y = 320)
label_var.set("Esperando datos...")

# Resto de tu código de interfaz
def simulacion():
    botons = []
    objects = []

    def destroy1():
        if len(objects) > 0:
            for object in objects:
                object.destroy()

    def nodes():
        client_thread = threading.Thread(target=MoveRob, args=(2, 3, 4))
        client_thread.start()
        client_thread.join()

    def start():
        threading.Thread(target=nodes).start()

    def RobotFR():
        destroy1()
        Robot = Frame(GUI1, bg="lightblue")
        Robot.place(x=10, y=20, width=500, height=200)

        TlRobot = Label(Robot, text="Movimiento Robot", bg="lightblue")
        TlRobot.pack()

        objects.append(Robot)

    def BrazoFR():
        destroy1()

        def MoverBrazo():
            cd = "pwd"
            subprocess.run(cd, shell=True)
            source = "source install/local_setup.bash"
            subprocess.run(source, shell=True)
            launch1 = f"ros2 run si MoveArmClient {armi[0]} {armi[1]} {armi[2]} {armi[3]} {armi[4]} {armi[5]}"
            subprocess.run(launch1, shell=True)

        def Simular2(x, y, z):
            cd = "pwd"
            subprocess.run(cd, shell=True)
            source = "source install/local_setup.bash"
            subprocess.run(source, shell=True)
            launch1 = f"ros2 run ixnaminki2_remote plan_client {x} {y} {z}"
            subprocess.run(launch1, shell=True)

        Brazo = Frame(GUI1, bg="lightblue")
        Brazo.place(x=10, y=20, width=500, height=200)

        TlBrazo = Label(Brazo, text="Movimiento Brazo", bg="lightblue")
        TlBrazo.pack()

        def changes():
            x = str(SliderX.get())
            y = str(SliderY.get())
            z = str(SliderZ.get())

            Simular2(x, y, z)

        Brazo2 = Frame(GUI1, bg="lightblue")
        Brazo2.place(x=10, y=220, width=500, height=100)

        SliderX = Scale(Brazo, from_=-1000, to=1000, orient=HORIZONTAL, length=300)
        SliderX.pack(pady=8)

        SliderY = Scale(Brazo, from_=-1000, to=1000, orient=HORIZONTAL, length=300)
        SliderY.pack(pady=8)

        SliderZ = Scale(Brazo, from_=0, to=1000, orient=HORIZONTAL, length=300)
        SliderZ.pack(pady=8)

        Simular = Button(Brazo2, text="Simular", command=changes)
        Mover = Button(Brazo2, text="Mover", command=MoverBrazo)
        Simular.place(relx=0.15, rely=0.25, relwidth=0.25, relheight=0.5)
        Mover.place(relx=0.60, rely=0.25, relwidth=0.25, relheight=0.5)

        objects.append(Brazo)
        objects.append(Brazo2)

    def CLawFR():
        ClawMode = Frame(GUI1, bg="lightblue")
        ClawMode.place(x=10, y=320, width=500, height=100)

        ClawBtn1 = Button(ClawMode, text="Garra Cerrada", command=OpClaw)
        ClawBtn2 = Button(ClawMode, text="Garra Abierta", command=ClClaw)
        ClawBtn3 = Button(ClawMode, text="Girar Garra", command=RtClaw)
        ClawBtn1.place(relx=0.02, rely=0.2, relwidth=0.3, relheight=0.6)
        ClawBtn2.place(relx=0.35, rely=0.2, relwidth=0.3, relheight=0.6)
        ClawBtn3.place(relx=0.68, rely=0.2, relwidth=0.3, relheight=0.6)

        def ask_quit():
            GUI1.destroy()

        GUI1.protocol("WM_DELETE_WINDOW", ask_quit)

        objects.append(ClawMode)

    def MovimientoFR():
        Mov = Frame(GUI1, bg="lightblue")
        Mov.place(x=500, y=20, width=200, height=300)

        TlMov = Label(Mov, text="Movimiento", bg="lightblue")
        TlMov.pack()

        ClawBtn1 = Button(Mov, text="Robot", command=RobotFR)
        ClawBtn2 = Button(Mov, text="Brazo", command=BrazoFR)
        ClawBtn3 = Button(Mov, text="Garra", command=CLawFR)
        ClawBtn1.place(relx=0.2, rely=0.15, relwidth=0.6, relheight=0.25)
        ClawBtn2.place(relx=0.2, rely=0.42, relwidth=0.6, relheight=0.25)
        ClawBtn3.place(relx=0.2, rely=0.69, relwidth=0.6, relheight=0.25)

    def Launcher():
        ls = "ls"
        subprocess.run(ls, shell=True)
        cd = "cd"
        subprocess.run(cd, shell=True)
        subprocess.run(ls, shell=True)
        cd2 = "cd .."
        subprocess.run(cd2, shell=True)
        subprocess.run(ls, shell=True)
        source = "source install/local_setup.bash"
        subprocess.run(source, shell=True)
        subprocess.run(cd, shell=True)
        launch1 = "ros2 launch ixnaminki2_moveit arm.launch.py"
        subprocess.run(launch1, shell=True)

    def MoveServer(x, y, z):
        cd = "ls"
        subprocess.run(cd, shell=True)
        source = "source install/local_setup.bash"
        subprocess.run(source, shell=True)
        launch1 = "ros2 run movimiento move_server"
        subprocess.run(launch1, shell=True)

    def MoveRob(x, y, z):
        cd = "ls"
        subprocess.run(cd, shell=True)
        source = "source install/local_setup.bash"
        subprocess.run(source, shell=True)
        launch1 = f"ros2 run si MoveRob {x} {y} {z}"
        subprocess.run(launch1, shell=True)

    def OpClaw():
            cd = "pwd"
            subprocess.run(cd, shell=True)
            source = "source install/local_setup.bash"
            subprocess.run(source, shell=True)
            launch1 = f"ros2 run si MoveArmClient 3000 3000 3000 3000 3000 3000"
            subprocess.run(launch1, shell=True)

    def ClClaw():
            cd = "pwd"
            subprocess.run(cd, shell=True)
            source = "source install/local_setup.bash"
            subprocess.run(source, shell=True)
            launch1 = f"ros2 run si MoveArmClient 3000 3000 3000 3000 3000 3000"
            subprocess.run(launch1, shell=True)

    def RtClaw():
        pass

    def otros():
        Launcher1 = Button(GUI1, text="LAUNCHER", command=Launcher)
        Launcher1.place(x=530, y=80, width=150, height=150)

    MovimientoFR()
    # otros()

simulacion()

# Iniciar el mainloop de Tkinter
GUI1.mainloop()

# Limpiar ROS 2 al cerrar la aplicación
ejes_subscriber.destroy_node()
rclpy.shutdown()
ros_thread.join()

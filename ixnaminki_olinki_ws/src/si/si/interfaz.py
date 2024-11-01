from tkinter import *
import os
import subprocess
import threading


GUI1 = Tk()
GUI1.title("GUI1")
GUI1.geometry("700x500")
GUI1.resizable(False, False)

Titulo = Label(GUI1, text= "Lectura de sensores")
Titulo.pack()

armi = []

def arreglo(armi1):
    for i in range(6):
        armi[i] = armi1[i]

def simulacion():
    botons = []
    objects = []
    armi = []

    def destroy1():
        if(len(objects)>0):
            for object in objects:
                object.destroy()

    def nodes():
        client_thread = threading.Thread(target = MoveRob(2,3,4))

        client_thread.start()

        client_thread.join()

    def start():
        threading.Thread(target=nodes).start()

    def RobotFR():
        destroy1()
        Robot = Frame(GUI1, bg = "lightblue")
        Robot.place(x = 10, y = 20, width = 500, height = 200)

        TlRobot = Label(Robot, text = "Movimiento Robot", bg = "lightblue")
        TlRobot.pack()

        objects.append(Robot)

    def BrazoFR():
        destroy1()

        def MoverBrazo(armi):
            cd = "pwd"
            subprocess.run(cd, shell=True)
            source = "source install/local_setup.bash"
            subprocess.run(source, shell=True)
            launch1 = f"ros2 run si CambioEjes {armi}"
            subprocess.run(launch1, shell=True)

        def Simular2(x,y,z):
            #cd1 = "cd"
            #subprocess.run(cd1, shell=True)
            #cd2 = "cd ixnaminki_olinki_ws"
            #subprocess.run(cd2, shell=True)
            cd = "pwd"
            subprocess.run(cd, shell=True)
            source = "source install/local_setup.bash"
            subprocess.run(source, shell=True)
            launch1 = f"ros2 run ixnaminki2_remote plan_client {x} {y} {z}"
            subprocess.run(launch1, shell=True)

        Brazo = Frame(GUI1, bg = "lightblue")
        Brazo.place(x = 10, y = 20, width = 500, height = 200)

        TlBrazo = Label(Brazo, text = "Movimiento Brazo", bg = "lightblue")
        TlBrazo.pack()

        def changes():
            x = str(SliderX.get())
            y = str(SliderY.get())
            z = str(SliderZ.get())

            Simular2(x,y,z)

        Brazo2 = Frame(GUI1, bg = "lightblue")
        Brazo2.place(x = 10, y = 220, width = 500, height = 100)

        SliderX = Scale(Brazo, from_ = -700, to = 700, orient = HORIZONTAL, length = 300)
        SliderX.pack(pady = 8)

        SliderY = Scale(Brazo, from_ = -700, to = 700, orient = HORIZONTAL, length = 300)
        SliderY.pack(pady = 8)

        SliderZ = Scale(Brazo, from_ = 0, to = 700, orient = HORIZONTAL, length = 300)
        SliderZ.pack(pady = 8)

        Simular = Button(Brazo2, text = "Simular", command = changes)
        Mover = Button(Brazo2, text = "Mover", command = MoverBrazo)
        Simular.place(relx = .15, rely = 0.25, relwidth = .25, relheight = .5)
        Mover.place(relx = .60, rely = 0.25, relwidth = .25, relheight = .5)

        objects.append(Brazo)
        objects.append(Brazo2)
    
    def CLawFR():
        ClawMode = Frame(GUI1, bg = "lightblue")
        ClawMode.place(x = 10, y = 320, width = 500, height = 100)

        ClawBtn1 = Button(ClawMode, text = "Garra Cerrada", command = OpClaw)
        ClawBtn2 = Button(ClawMode, text = "Garra abierta", command = ClClaw)
        ClawBtn3 = Button(ClawMode, text = "Girar Garra", command = RtClaw)
        ClawBtn1.place(relx = 0.02, rely = 0.2, relwidth = 0.3, relheight = 0.6)
        ClawBtn2.place(relx = 0.35, rely = 0.2, relwidth = 0.3, relheight = 0.6)
        ClawBtn3.place(relx = 0.68, rely = 0.2, relwidth = 0.3, relheight = 0.6)

        def ask_quit():
            GUI1.destroy()

        GUI1.protocol("Delete Window", ask_quit)

        objects.append(ClawMode)

    def MovimientoFR():
        Mov = Frame(GUI1, bg = "lightblue")
        Mov.place(x = 500, y = 20, width = 200, height = 300)

        TlMov = Label(Mov, text = "Movimiento", bg = "lightblue")
        TlMov.pack()

        ClawBtn1 = Button(Mov, text = "Robot", command = RobotFR)
        ClawBtn2 = Button(Mov, text = "Brazo", command = BrazoFR)
        ClawBtn3 = Button(Mov, text = "Garra", command = CLawFR)
        ClawBtn1.place(relx = 0.2, rely = 0.15, relwidth = 0.6, relheight = 0.25)
        ClawBtn2.place(relx = 0.2, rely = 0.42, relwidth = 0.6, relheight = 0.25)
        ClawBtn3.place(relx = 0.2, rely = 0.69, relwidth = 0.6, relheight = 0.25)

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

    def MoveServer(x,y,z):
    #    cd1 = "cd"
     #   subprocess.run(cd1, shell=True)
      #  cd2 = "cd .."
       # subprocess.run(cd2, shell=True)
        cd = "ls"
        subprocess.run(cd, shell=True)
        source = "source install/local_setup.bash"
        subprocess.run(source, shell=True)
        launch1 = "ros2 run movimiento move_server"         
        subprocess.run(launch1, shell=True)

    def MoveRob(x,y,z):
       # cd1 = "cd"
       # subprocess.run(cd1, shell=True)
        #cd2 = "cd .."
        #subprocess.run(cd2, shell=True)
        cd = "ls"
        subprocess.run(cd, shell=True)
        source = "source install/local_setup.bash"
        subprocess.run(source, shell=True)
        launch1 = f"ros2 run si MoveRob {x} {y} {z}"         
        subprocess.run(launch1, shell=True)


    def OpClaw():
        a = a
    
    def ClClaw():
        a = a
    
    def RtClaw():
        a = a
    

    def otros():
        Launcher1 = Button(GUI1, text = "LAUNCHER", command = Launcher)
        Launcher1.place(x = 530, y = 80, width = 150, height = 150)

        #RbImage = PhotoImage(file = 'robot.png')
        #lblim1 = Label(GUI1, image = RbImage)
        #lblim1.place(x = 700, y = 500, width = 200, height = 500)

    MovimientoFR()
    #otros()

simulacion()

GUI1.mainloop()
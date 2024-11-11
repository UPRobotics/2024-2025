import customtkinter as ctk
import mysql.connector
import cv2
from PIL import Image, ImageTk
from threading import Thread
import time

class ToolManagementSystem:
    def __init__(self):
        self.root = ctk.CTk()
        self.root.title("Sistema de Gestión de Herramientas")
        self.root.geometry("1000x600")
        ctk.set_appearance_mode("system")
        ctk.set_default_color_theme("blue")

        self.conexion = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="crisler795",
            database="almacenamientoo"
        )
        self.cursor = self.conexion.cursor()
        self.crear_tabla_tipos()
        self.current_id = ctk.StringVar()
        self.scanning = False

        self.create_gui()

    def create_gui(self):
        #Frame principal
        main_frame = ctk.CTkFrame(self.root)
        main_frame.pack(fill="both", expand=True, padx=20, pady=20)

        #Frame superior para entrada y botones
        top_frame = ctk.CTkFrame(main_frame)
        top_frame.pack(fill="x", padx=10, pady=10)

        #Entrada de ID
        id_label = ctk.CTkLabel(top_frame, text="ID:", font=("Roboto", 14))
        id_label.pack(side="left", padx=5)

        id_entry = ctk.CTkEntry(top_frame, textvariable=self.current_id, 
                               width=200, height=35)
        id_entry.pack(side="left", padx=5)

        #Botones principales
        scan_button = ctk.CTkButton(top_frame, text="Escanear QR", 
                                  command=self.start_scanning, width=120, height=35)
        scan_button.pack(side="left", padx=5)

        save_button = ctk.CTkButton(top_frame, text="Guardar", 
                                  command=self.save_item, width=120, height=35)
        save_button.pack(side="left", padx=5)

        delete_button = ctk.CTkButton(top_frame, text="Eliminar", 
                                    command=self.delete_item, width=120, height=35)
        delete_button.pack(side="left", padx=5)
        self.data_frame = ctk.CTkFrame(main_frame)
        self.data_frame.pack(fill="both", expand=True, padx=10, pady=10)

        #Pestañas
        self.tabview = ctk.CTkTabview(self.data_frame)
        self.tabview.pack(fill="both", expand=True)

        #Pestaña de Herramientas
        tools_tab = self.tabview.add("Herramientas")
        self.create_tools_view(tools_tab)

        #Pestaña de Cajones
        drawers_tab = self.tabview.add("Cajones")
        self.create_drawers_view(drawers_tab)

        #Pestaña de Tipos
        types_tab = self.tabview.add("Tipos")
        self.create_types_view(types_tab)

        self.message_label = ctk.CTkLabel(main_frame, text="", 
                                        font=("Roboto", 12))
        self.message_label.pack(pady=10)

    def create_tools_view(self, parent):
        #Crear un Textbox para mostrar las herramientas
        self.tools_text = ctk.CTkTextbox(parent, width=800, height=300)
        self.tools_text.pack(fill="both", expand=True, padx=10, pady=10)
        self.update_tools_view()

    def create_drawers_view(self, parent):
        self.drawers_text = ctk.CTkTextbox(parent, width=800, height=300)
        self.drawers_text.pack(fill="both", expand=True, padx=10, pady=10)
        self.update_drawers_view()

    def create_types_view(self, parent):
        add_type_frame = ctk.CTkFrame(parent)
        add_type_frame.pack(fill="x", padx=10, pady=10)

        self.new_type_code = ctk.StringVar()
        self.new_type_name = ctk.StringVar()

        #Entradas para nuevo tipo
        ctk.CTkLabel(add_type_frame, text="Código:").pack(side="left", padx=5)
        ctk.CTkEntry(add_type_frame, textvariable=self.new_type_code, 
                    width=100).pack(side="left", padx=5)
        
        ctk.CTkLabel(add_type_frame, text="Nombre:").pack(side="left", padx=5)
        ctk.CTkEntry(add_type_frame, textvariable=self.new_type_name, 
                    width=200).pack(side="left", padx=5)

        ctk.CTkButton(add_type_frame, text="Agregar Tipo", 
                     command=self.add_new_type).pack(side="left", padx=5)

        #Lista de tipos existentes
        self.types_text = ctk.CTkTextbox(parent, width=800, height=250)
        self.types_text.pack(fill="both", expand=True, padx=10, pady=10)
        self.update_types_view()

    def start_scanning(self):
        if not self.scanning:
            self.scanning = True
            Thread(target=self.scan_qr).start()
            self.show_message("Escaneando código QR...")
        else:
            self.scanning = False
            self.show_message("Escaneo cancelado")

    def scan_qr(self):
        cap = cv2.VideoCapture(0)
        detector = cv2.QRCodeDetector()

        while self.scanning:
            ret, frame = cap.read()
            if ret:
                val, pts, _ = detector.detectAndDecode(frame)
                if val:
                    self.current_id.set(val)
                    self.scanning = False
                    self.show_message(f"Código QR detectado: {val}")
                    break

                cv2.imshow("QR Scanner", frame)
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break

        cap.release()
        cv2.destroyAllWindows()

    def save_item(self):
        id_value = self.current_id.get()
        if id_value:
            if self.procesar_id(id_value):
                self.show_message(f"Item {id_value} guardado exitosamente")
                self.update_all_views()
            else:
                self.show_message("Error al guardar el item")
        else:
            self.show_message("Por favor ingrese un ID")

    def delete_item(self):
        id_value = self.current_id.get()
        if id_value:
            self.eliminar_elemento(id_value)
            self.show_message(f"Item {id_value} eliminado exitosamente")
            self.update_all_views()
        else:
            self.show_message("Por favor ingrese un ID")

    def show_message(self, message):
        self.message_label.configure(text=message)
        self.root.after(3000, lambda: self.message_label.configure(text=""))

    def update_all_views(self):
        self.update_tools_view()
        self.update_drawers_view()
        self.update_types_view()

    def update_tools_view(self):
        self.tools_text.delete("1.0", "end")
        self.cursor.execute("""
            SELECT h.codigo_id, h.tipo_herramienta, h.numero_herramienta, c.codigo_id as cajon
            FROM Herramientas h
            LEFT JOIN Relaciones r ON h.id = r.id_herramienta
            LEFT JOIN Cajones c ON r.id_cajon = c.id
        """)
        tools = self.cursor.fetchall()
        
        header = f"{'ID':<10} {'Tipo':<20} {'Número':<10} {'Cajón':<10}\n"
        self.tools_text.insert("1.0", header + "-" * 50 + "\n")
        
        for tool in tools:
            line = f"{tool[0]:<10} {tool[1]:<20} {tool[2]:<10} {tool[3] or 'N/A':<10}\n"
            self.tools_text.insert("end", line)

    def update_drawers_view(self):
        self.drawers_text.delete("1.0", "end")
        self.cursor.execute("""
            SELECT codigo_id, tipo_herramienta, numero_caja
            FROM Cajones
        """)
        drawers = self.cursor.fetchall()
        
        header = f"{'ID':<10} {'Tipo':<20} {'Número':<10}\n"
        self.drawers_text.insert("1.0", header + "-" * 40 + "\n")
        
        for drawer in drawers:
            line = f"{drawer[0]:<10} {drawer[1]:<20} {drawer[2]:<10}\n"
            self.drawers_text.insert("end", line)

    def update_types_view(self):
        self.types_text.delete("1.0", "end")
        self.cursor.execute("SELECT codigo, nombre FROM TiposHerramientas")
        types = self.cursor.fetchall()
        
        header = f"{'Código':<10} {'Nombre':<30}\n"
        self.types_text.insert("1.0", header + "-" * 40 + "\n")
        
        for type_ in types:
            line = f"{type_[0]:<10} {type_[1]:<30}\n"
            self.types_text.insert("end", line)

    def add_new_type(self):
        code = self.new_type_code.get()
        name = self.new_type_name.get()
        
        if code and name:
            try:
                self.cursor.execute("""
                    INSERT INTO TiposHerramientas (codigo, nombre)
                    VALUES (%s, %s)
                """, (code, name))
                self.conexion.commit()
                self.show_message(f"Tipo {name} agregado exitosamente")
                self.update_types_view()
                self.new_type_code.set("")
                self.new_type_name.set("")
            except mysql.connector.Error as err:
                self.show_message(f"Error al agregar tipo: {err}")
        else:
            self.show_message("Por favor complete todos los campos")

    def run(self):
        self.root.mainloop()

    def crear_tabla_tipos(self):
        query = """
        CREATE TABLE IF NOT EXISTS TiposHerramientas (
            codigo CHAR(1) PRIMARY KEY,
            nombre VARCHAR(50) NOT NULL
        )
        """
        self.cursor.execute(query)
        
        #tipos predeterminados
        query_check = "SELECT COUNT(*) FROM TiposHerramientas"
        self.cursor.execute(query_check)
        if self.cursor.fetchone()[0] == 0:
            tipos_predeterminados = [
                ('d', 'Destornillador'),
                ('m', 'Martillo'),
                ('p', 'Pinzas'),
                ('l', 'Llaves')
            ]
            query_insert = "INSERT INTO TiposHerramientas (codigo, nombre) VALUES (%s, %s)"
            self.cursor.executemany(query_insert, tipos_predeterminados)
            self.conexion.commit()

    def obtener_tipos_herramientas(self):
        #Obtiene todos los tipos de herramientas registrados
        query = "SELECT codigo, nombre FROM TiposHerramientas"
        self.cursor.execute(query)
        return {codigo: nombre for codigo, nombre in self.cursor.fetchall()}

    def verificar_id_existente(self, codigo_id):
        if codigo_id[0] == 'c':
            query = "SELECT COUNT(*) FROM Cajones WHERE codigo_id = %s"
        else:
            query = "SELECT COUNT(*) FROM Herramientas WHERE codigo_id = %s"
        
        self.cursor.execute(query, (codigo_id,))
        count = self.cursor.fetchone()[0]
        return count > 0

    def agregar_nuevo_tipo_herramienta(self, tipo):
        print(f"\nTipo de herramienta '{tipo}' no reconocido.")
        while True:
            opcion = input("¿Desea agregar este nuevo tipo de herramienta al sistema? (s/n): ").lower()
            if opcion == 's':
                nombre = input("Ingrese el nombre completo para este tipo de herramienta: ")
                query = "INSERT INTO TiposHerramientas (codigo, nombre) VALUES (%s, %s)"
                self.cursor.execute(query, (tipo, nombre))
                self.conexion.commit()
                print(f"Nuevo tipo de herramienta '{nombre}' (código: {tipo}) agregado al sistema.")
                return nombre
            elif opcion == 'n':
                return None
            else:
                print("Por favor, ingrese 's' o 'n'")

    def procesar_id(self, codigo_id):
        if self.verificar_id_existente(codigo_id):
            print(f"Error: El ID '{codigo_id}' ya existe en la base de datos.")
            return False

        tipos_herramientas = self.obtener_tipos_herramientas()

        if codigo_id[0] == 'c':  # Si es una caja
            tipo_herramienta = codigo_id[1]
            numero_caja = codigo_id[2:]
            
            if tipo_herramienta not in tipos_herramientas:
                tipo_nombre = self.agregar_nuevo_tipo_herramienta(tipo_herramienta)
                if not tipo_nombre:
                    print("Operación cancelada.")
                    return False
            else:
                tipo_nombre = tipos_herramientas[tipo_herramienta]
            
            self.insertar_cajon(codigo_id, tipo_nombre, numero_caja)
            
        else:  # Si es una herramienta
            tipo_herramienta = codigo_id[0]
            numero_herramienta = codigo_id[1:]
            
            if tipo_herramienta not in tipos_herramientas:
                tipo_nombre = self.agregar_nuevo_tipo_herramienta(tipo_herramienta)
                if not tipo_nombre:
                    print("Operación cancelada.")
                    return False
            else:
                tipo_nombre = tipos_herramientas[tipo_herramienta]
            
            self.insertar_herramienta(codigo_id, tipo_nombre, numero_herramienta)
        
        return True

    def insertar_cajon(self, codigo_id, tipo_herramienta, numero_caja):
        query = "INSERT INTO Cajones (codigo_id, tipo_herramienta, numero_caja) VALUES (%s, %s, %s)"
        self.cursor.execute(query, (codigo_id, tipo_herramienta, numero_caja))
        self.conexion.commit()
        print(f"Caja '{codigo_id}' insertada en la base de datos.")

    def insertar_herramienta(self, codigo_id, tipo_herramienta, numero_herramienta):
        query_herramienta = "INSERT INTO Herramientas (codigo_id, tipo_herramienta, numero_herramienta) VALUES (%s, %s, %s)"
        self.cursor.execute(query_herramienta, (codigo_id, tipo_herramienta, numero_herramienta))
        self.conexion.commit()
        
        # Buscar un cajón compatible
        query_cajon = "SELECT codigo_id FROM Cajones WHERE tipo_herramienta = %s"
        self.cursor.execute(query_cajon, (tipo_herramienta,))
        resultado = self.cursor.fetchone()
        
        if resultado:
            codigo_id_cajon = resultado[0]
            query_id_herramienta = "SELECT id FROM Herramientas WHERE codigo_id = %s"
            self.cursor.execute(query_id_herramienta, (codigo_id,))
            id_herramienta = self.cursor.fetchone()[0]
            
            # Relacionar herramienta con cajón
            query_relacion = "INSERT INTO Relaciones (id_cajon, id_herramienta) VALUES ((SELECT id FROM Cajones WHERE codigo_id = %s), %s)"
            self.cursor.execute(query_relacion, (codigo_id_cajon, id_herramienta))
            self.conexion.commit()
            print(f"Herramienta '{codigo_id}' ha sido asignada automáticamente al cajón con ID {codigo_id_cajon}.")
        else:
            print("No se encontró un cajón adecuado para esta herramienta.")

    def ver_herramientas_en_caja(self, codigo_caja):
        query = """
        SELECT Herramientas.codigo_id, Herramientas.tipo_herramienta, Herramientas.numero_herramienta
        FROM Relaciones
        JOIN Cajones ON Relaciones.id_cajon = Cajones.id
        JOIN Herramientas ON Relaciones.id_herramienta = Herramientas.id
        WHERE Cajones.codigo_id = %s
        """
        self.cursor.execute(query, (codigo_caja,))
        resultados = self.cursor.fetchall()
        
        if resultados:
            print(f"Herramientas en la caja {codigo_caja}:")
            for herramienta in resultados:
                print(f"ID: {herramienta[0]}, Tipo: {herramienta[1]}, Número: {herramienta[2]}")
        else:
            print(f"No se encontraron herramientas en la caja {codigo_caja}.")

    def ver_caja_de_herramienta(self, codigo_herramienta):
        query = """
        SELECT Cajones.codigo_id 
        FROM Relaciones
        JOIN Herramientas ON Relaciones.id_herramienta = Herramientas.id
        JOIN Cajones ON Relaciones.id_cajon = Cajones.id
        WHERE Herramientas.codigo_id = %s
        """
        self.cursor.execute(query, (codigo_herramienta,))
        resultado = self.cursor.fetchone()
        
        if resultado:
            codigo_caja = resultado[0]
            print(f"La herramienta '{codigo_herramienta}' está guardada en la caja '{codigo_caja}'.")
        else:
            print(f"No se encontró una caja para la herramienta '{codigo_herramienta}'.")

    def eliminar_elemento(self, codigo_id):
        if codigo_id[0] == 'c':  # Si es una caja
            # Eliminar las relaciones
            query_relacion = """
            DELETE FROM Relaciones 
            WHERE id_cajon = (SELECT id FROM Cajones WHERE codigo_id = %s LIMIT 1)
            """
            self.cursor.execute(query_relacion, (codigo_id,))
            self.conexion.commit()

            # Eliminar la caja
            query_cajon = "DELETE FROM Cajones WHERE codigo_id = %s"
            self.cursor.execute(query_cajon, (codigo_id,))
            self.conexion.commit()
            print(f"Caja '{codigo_id}' eliminada de la base de datos.")

        else:  # Si es una herramienta
            # Eliminar las relaciones
            query_relacion = """
            DELETE FROM Relaciones 
            WHERE id_herramienta = (SELECT id FROM Herramientas WHERE codigo_id = %s LIMIT 1)
            """
            self.cursor.execute(query_relacion, (codigo_id,))
            self.conexion.commit()

            # Eliminar la herramienta
            query_herramienta = "DELETE FROM Herramientas WHERE codigo_id = %s"
            self.cursor.execute(query_herramienta, (codigo_id,))
            self.conexion.commit()
            print(f"Herramienta '{codigo_id}' eliminada de la base de datos.")

if __name__ == "__main__":
    app = ToolManagementSystem()
    app.run()
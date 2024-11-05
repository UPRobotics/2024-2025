#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
from formatos.srv import Moverob, Movearm

class ServiceServer(Node):
    def __init__(self):
        super().__init__('service_server')

        # Crear servidores de servicio para Moverob y Movearm
        self.moverob_service = self.create_service(Moverob, 'moverob', self.moverob_callback)
        self.movearm_service = self.create_service(Movearm, 'movearm', self.movearm_callback)

        self.get_logger().info("Service server node is ready and waiting for requests...")

    def moverob_callback(self, request, response):
        # Procesa la solicitud de Moverob
        self.get_logger().info(f"Received Moverob request with armi: {request.armi}")

        # Ejemplo de respuesta
        response.error = False  # o True si ocurre un error
        return response

    def movearm_callback(self, request, response):
        # Procesa la solicitud de Movearm
        self.get_logger().info(f"Received Movearm request with d1: {request.d1}, d2: {request.d2}, flippers: {request.flippers}")

        # Ejemplo de respuesta
        response.error = False  # o True si ocurre un error
        return response

def main(args=None):
    rclpy.init(args=args)
    node = ServiceServer()

    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass

    # Cerrar el nodo de ROS 2
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

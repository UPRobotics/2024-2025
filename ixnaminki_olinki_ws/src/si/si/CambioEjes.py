import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
from formatos.srv import Movearm


class CambiosEjes(Node):
    def __init__(self):
        super().__init__("table_server")
        self.service = self.create_service(Movearm, "cambio_ejes", self.service_callback)
        self.publisher = self.create_publisher(Float32MultiArray, 'cambio_ejes_topic', 10)
        self.get_logger().info("Service 'cambio_ejes' is ready")

    def service_callback(self, req, res):
        self.get_logger().info(
            f"New Request Received: "
            f"1: {req.armi[0]}, 2: {req.armi[1]}, 3: {req.armi[2]}, "
            f"4: {req.armi[3]}, 5: {req.armi[4]}, 6: {req.armi[5]}"
        )
        msg = Float32MultiArray()
        msg.data = [(float)(req.armi[0]), (float)(req.armi[1]), (float)(req.armi[2]), (float)(req.armi[3]), (float)(req.armi[4]), (float)(req.armi[5])]
        self.publisher.publish(msg)
        
        self.get_logger().info(f"Returning arreglo: {msg.data}")

        return res


def main():
    rclpy.init()
    cambios_server = CambiosEjes()
    rclpy.spin(cambios_server)
    cambios_server.destroy_node()
    rclpy.shutdown()


if __name__ == "__main__":
    main()
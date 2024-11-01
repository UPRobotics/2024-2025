import rclpy
from rclpy.node import Node
from formatos.srv import Movearm
import sys

class MoveRobClient(Node):
    def __init__(self,armi):
        super().__init__("ixnaminki_server_move_arm")
        
        self.client_ = self.create_client(Movearm, "move_arm")

        while not self.client_.wait_for_service(timeout_sec = 1.0):
            self.get_logger().info("Service not available, waiting again...")

        self.req_ = Movearm.Request()
        self.req_.armi = armi

        self.future_ = self.client_.call_async(self.req_)
        self.future_.add_done_callback(self.responseCallback)

    def responseCallback(self,future):
        self.get_logger().info("Service Response %d" % (future.result().error))

def main ():
    rclpy.init()

    if len(sys.argv) != 7:
        print("Wrong number of arguments! Usage: MoverRobServer")
        return -1
    

    armi = [float(sys.argv[i]) for i in range(1, 7)]
    Move_rob_client = MoveRobClient(armi)
    rclpy.spin(Move_rob_client)
    Move_rob_client.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

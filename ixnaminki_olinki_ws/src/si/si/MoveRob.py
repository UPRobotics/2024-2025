import rclpy
from rclpy.node import Node
from formatos.srv import Moverob
import sys

class MoveRobClient(Node):
    def __init__(self,d1,d2,flippers):
        super().__init__("ixnaminki_server_move_robot")
        
        self.client_ = self.create_client(Moverob, "move_robot")

        while not self.client_.wait_for_service(timeout_sec = 1.0):
            self.get_logger().info("Service not available, waiting again...")

        self.req_ = Moverob.Request()
        self.req_.d1 = d1
        self.req_.d2 = d2
        self.req_.flippers = flippers

        self.future_ = self.client_.call_async(self.req_)
        self.future_.add_done_callback(self.responseCallback)

    def responseCallback(self,future):
        self.get_logger().info("Service Response %d" % (future.result().error))

def main ():
    rclpy.init()

    if len(sys.argv) != 4:
        print("Wrong number of arguments! Usage: MoverRobServer ")
        return -1
    
    Move_rob_client = MoveRobClient(int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]))
    rclpy.spin(Move_rob_client)
    Move_rob_client.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
#include<iostream>
#include <unistd.h>
#include<termios.h>
#include "rclcpp/rclcpp.hpp"
#include "formatos/srv/moverob.hpp"

char getchar_(){
    char buf=0;
    struct termios old={0};
    if(tcgetattr(0, &old) < 0)
        perror("tcsetattr()");
    old.c_lflag &= ~ICANON;
    old.c_lflag &= ~ECHO;
    old.c_cc[VMIN] = 1;
    old.c_cc[VTIME] = 0;
    if(tcsetattr(0, TCSANOW, &old)<0)
        perror("tcsetattr ICANON");
    if(read(0, &buf, 1)<0)
        perror("read()");
    old.c_lflag |= ICANON;
    old.c_lflag |= ECHO;
    if(tcsetattr(0, TCSADRAIN, &old) < 0)
        perror("tcsetattr ~ICANON");
    return buf;
} 

std::shared_ptr<rclcpp::Node> node;

rclcpp::Client<formatos::srv::Moverob>::SharedPtr clientRob;

int main(int argc, char ** argv){

    rclcpp::init(argc, argv);

	node = rclcpp::Node::make_shared("reader_client");


	clientRob = node->create_client<formatos::srv::Moverob>("move_robot");	



    double vel = 0.2;
    while(1){
        char x = getchar_();
        auto request = std::make_shared<formatos::srv::Moverob::Request>();
        double r1=0, r2=0;

        if(x=='W') {
            r1=r2=vel;
        }else if(x=='A'){
            r1=vel;
            r2=-vel;
        }else if(x=='D'){
            r1=-vel;
            r2=vel;
        }else if(x=='S'){
            r1=r2=-vel;
        }else if(x=='Q'){
            r1=r2=0;
        }else {
            vel+=0.0;
        }
        request->d1 = r1;
        request->d2 = r2;
        request->flippers = 0;

        RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "sending: r1=[%f]        r2=[%f]       flipper=[%f]", r1, r2, 0);
        auto result = clientRob->async_send_request(request);
        if (rclcpp::spin_until_future_complete(node, result) == rclcpp::FutureReturnCode::SUCCESS){
            RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "succes: %d", true);
        }else{
            RCLCPP_ERROR(rclcpp::get_logger("rclcpp"), "Failed to call service direcciones");
        }
    }

    rclcpp::shutdown();
    return 0;
}
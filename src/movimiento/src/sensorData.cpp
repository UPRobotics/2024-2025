// this will be heald on the raspberry
#include "rclcpp/rclcpp.hpp"
#include "formatos/msg/sensor.hpp"

#include <string>
#include <memory>
#include <chrono>
#include <thread>
#include <unistd.h>
#include <stdio.h>
#include <functional>

using namespace std::chrono_literals;


float read_sensors(){
    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Reading data sensors");
    return 0.0;
}

class SensorPublisher : public rclcpp::Node
{
  public:
    SensorPublisher()
    : Node("sensor_publisher")
    {
      publisher_ = this->create_publisher<formatos::msg::Sensor>("sensor", 10);
      timer_ = this->create_wall_timer(
      500ms, std::bind(&SensorPublisher::timer_callback, this));
    }

  private:
    void timer_callback()
    {
        auto message = formatos::msg::Sensor();
        message.sensor1 = read_sensors();
        
        RCLCPP_INFO(this->get_logger(), "Publicando");
        publisher_->publish(message);
    }
    rclcpp::TimerBase::SharedPtr timer_;
    rclcpp::Publisher<formatos::msg::Sensor>::SharedPtr publisher_;
};


int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<SensorPublisher>());
  rclcpp::shutdown();
  return 0;
}
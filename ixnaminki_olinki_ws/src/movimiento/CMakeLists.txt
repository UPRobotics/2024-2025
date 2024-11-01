cmake_minimum_required(VERSION 3.8)
project(movimiento)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()


find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(formatos)


add_executable(move_server src/movimiento.cpp)
ament_target_dependencies(move_server rclcpp formatos)


add_executable(sensor_pub src/sensorData.cpp) 
ament_target_dependencies(sensor_pub rclcpp formatos)


install(TARGETS
  move_server
  sensor_pub
  DESTINATION lib/${PROJECT_NAME}

)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  set(ament_cmake_copyright_FOUND TRUE)
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()


ament_package()

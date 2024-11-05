cmake_minimum_required(VERSION 3.8)
project(formatos)


# Asegurarse de que se muestren advertencias de compilación para el código C++
if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# Encontrar las dependencias de ament y generadores de interfaces de ROS
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)

# Generar los archivos de mensajes y servicios
rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/Sensor.msg"         # Archivo de mensaje (si lo necesitas)
  "srv/Moverob.srv"        # Archivo de servicio para mover el robot
  "srv/Movearm.srv"        # Archivo de servicio para mover el brazo
)

# Incluir las dependencias para las pruebas
if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

# Indicar que este es un paquete de ament
ament_package()

install(
  DIRECTORY scripts/
  DESTINATION lib/${PROJECT_NAME}
)

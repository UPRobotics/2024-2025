import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

ApplicationWindow { // Initialize main window
    visible: true
    width: 1920
    height: 1080
    title : "Up Robotics Interface"

    FocusScope{
        id: root
        anchors.fill: parent
        focus : true

     Rectangle{ //Background
        width: parent.width
        height: parent.height
        
     Image{ //Background
        anchors.fill: parent
        source: "../Background.png"
        fillMode: Image.PreserveAspectcrop

        }
        }

    
     Rectangle {  // Header
        id: header
        x: 0
        y: 0
        width: 1920
        height: 80
        color: "#2b2929"
        
     Image {  //Logo
        id: logo
        x: -16
        y: 0
        width: 100
        height: 80
        source: "../logo.png"
        fillMode: Image.PreserveAspectFit
        }      
        
     Switch {// On_Off Switch
        id: on_off_switch
        x: 150
        y: 18
        checked: false // Initial switch state
        background:Rectangle{
            color: on_off_switch.checked ? "#21641c" : "#64110f"
            radius: 30
            }
        onCheckedChanged: { //Conection with python and warnings text box
            if (checked){
                    pyInterface.switchOn()
                    warnings_text.text ="Robot On\n"
                } 
            else{
                    pyInterface.switchOff()
                    warnings_text.text ="Robot Off\n"
                }

        }
     }
     
     Text { // Text that changes wehne robot is on/off
        id: state
        x: 110
        y: 25
        font.pixelSize: 20
        font.styleName: "Thin"
        color: "#ffffff"
        text: on_off_switch.checked ? "On" : "Off" // text change when switch is clicked
     } 

     Button { //Voltage button
            id: volt
            x: 1100
            y: 15
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                source: "../Voltage.png"
                
            }

            onClicked:{
                sensors.color = "#ffad00"
                warnings_text.text = "Showing Voltage Data \n"
                sensors_text.text = pyInterface.showVoltage()
                

            }
        
     }

     Button { //Amperage button
            id: amp
            x: 1150
            y: 15
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                source: "../Amperage.png"
                
            }

            onClicked:{
                sensors.color="#12adc8"
                warnings_text.text = "Showing Amperage Data \n"
                sensors_text.text = pyInterface.showAmperage()


            }
        
     }
    
     Button { //Battery button
            id: bat
            x: 1200
            y: 15
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                source: "../Battery.png"
                
            }

            onClicked:{
                sensors.color="#5e18eb"
                warnings_text.text = "Showing Battery Data \n"
                sensors_text.text = pyInterface.showBattery()


            }
        
     }
     Button { //Co2 button
            id: co
            x: 1250
            y: 15
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                source: "../Co2.png"
                
            }

            onClicked:{
                sensors.color="#41c812"
                warnings_text.text = "Showing CO2 Data \n"
                sensors_text.text = pyInterface.showCo()


            }
        
     }
     }
        

    
     Rectangle { //Arm Control Box
        id: armcontrol
        x: 10
        y: 100
        width: 300
        height: 340
        opacity: 0.5
        color: "#1d1d1b"
        radius: 49
        

        
        Slider { // First SLider that control x position
            id: control_x
            x: 25
            y: 96
            width: 250
            height: 30
            from: 0
            to: 150
            value: 75

            onValueChanged:{
                set_value_x.text = String(Math.round(value))
                value = (Math.round(value))
                }

        }

        TextInput{ // Text input that changes the first slider value
            id: set_value_x
            width: 50
            x: 25
            y : 130
            color : "#ffffff"
            text: String(control_x.value)

            onTextChanged: {
                var newValue = parseFloat(text);
                if (!isNaN(newValue) && newValue >= control_x.from && newValue <= control_x.to) {
                    control_x.value = newValue;  // Sincronizar el Slider con el valor del TextInput

                }
            }
        }

        Slider { // Second slider that control y position
            id: control_y
            x: 25
            y: 168
            width: 250
            height: 30
            from: 0
            to: 150
            value: 75

            onValueChanged:{
                set_value_y.text = String(Math.round(value))
                value = (Math.round(value))
                }
        }

        TextInput{ // Text input that changes the second slider value
            id: set_value_y
            width: 50
            x: 25
            y : 202
            color : "#ffffff"
            text: String(control_y.value)

            onTextChanged: {
                var newValue = parseFloat(text);
                if (!isNaN(newValue) && newValue >= control_y.from && newValue <= control_y.to) {
                    control_y.value = newValue;  // Sincronizar el Slider con el valor del TextInput

                }
            }
        }
        
        Slider { // Third slider that control z position
            id: control_z
            x: 25
            y: 240
            width: 250
            height: 30
            from: 0
            to: 150
            value: 75

            onValueChanged:{
                set_value_z.text = String(Math.round(value))
                value = (Math.round(value))
                }
        }

        TextInput{ // Text input that changes the third slider value
            id: set_value_z
            width: 50
            x: 25
            y : 274
            color : "#ffffff"
            text: String(control_z.value)

            onTextChanged: {
                var newValue = parseFloat(text);
                if (!isNaN(newValue) && newValue >= control_z.from && newValue <= control_z.to) {
                    control_z.value = newValue; 

                }
            }
        }
        
        Button { // Button that extracts every slider value and conects it to python
            id: arm_changes
            x: 80
            y: 288
            text: qsTr("Apply Changes")
            flat: false
            background: Rectangle{
                color: "#857663"
                radius: 10
            }
            
            contentItem: Text{
                text: parent.text
                color: "white"
                font.pixelSize: 20
                font.styleName: "Thin"
            }

            onClicked:{
                pyInterface.getSlidersValues(control_x.value, control_y.value, control_z.value)
                warnings_text.text = "Robot Arm Position Updated \n"

            }
            
        }
        Button { // Button that extracts every slider value and conects it to python
            id: arm_reset
            x: 230
            y: 288
            text: qsTr("R")
            flat: false
            background: Rectangle{
                color: "#857663"
                radius: 10
            }
            
            contentItem: Text{
                text: parent.text
                color: "white"
                font.pixelSize: 20
                font.styleName: "Thin"
            }

            onClicked:{
                control_x.value = 75
                control_y.value = 75
                control_z.value = 75
                pyInterface.getSlidersValues(control_x.value, control_y.value, control_z.value)
                warnings_text.text = "Robot Arm Position Reseted \n"

            }
            
        }
            
        

        Text { // arm control box title
            id: arm_controtitle
            x: 55
            y: 24
            color: "#ffffff"
            text: qsTr("Arm Control")
            font.pixelSize: 30
            font.styleName: "Thin"
            font.bold: true
        }
     }

     Rectangle { // Warnings box
        id: warnings
        x: 10
        y: 460
        width: 300
        height: 130
        opacity: 0.5
        color: "#1d1d1b"
        radius: 49

        Text { // warnings box title
            id: warningstitle
            x: 70
            y: 24
            color: "White"
            text: qsTr("Warnings")
            font.pixelSize: 30
            font.styleName: "Thin"
            font.bold: true
        }
        
        TextArea{ // text area that shows the warning *need changes
            x:10
            y:54
            width:280
            height:100
            id: warnings_text
            readOnly:true
            wrapMode: Text.WordWrap
            placeholderText: "Welcome to UP Robotics Interface"
            color:"#ffffff"

        }}
    

    
     Button { //Front  button
            id: front
            x: 45
            y: 600
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                id : buttonfront
                source: "../front.png"
                
            }

        onClicked: {
                buttonfront.source = "../frontchanged.png"
                resetButtonfront.start()
                
            }

        Timer{
                id: resetButtonfront
                interval: 200
                repeat: false
                onTriggered:{
                    buttonfront.source = "../front.png"
                    
                }
            }
        
     }

     Button { //Back button
            id: back
            x: 45
            y: 645
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                id : buttonback
                source: "../back.png"
                
            }
            
            onClicked: {
                buttonback.source = "../backchanged.png"
                resetButtonback.start()
                
            }

        Timer{
                id: resetButtonback
                interval: 200
                repeat: false
                onTriggered:{
                    buttonback.source = "../back.png"
                    
                }
            }
        


        
     }

     Button { //Front1 button
            id: front1
            x: 105
            y: 600
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                id: buttonfront1
                source: "../front.png"
                
            }

        onClicked: {
                buttonfront1.source = "../frontchanged.png"
                resetButtonfront1.start()
                
            }

        Timer{
                id: resetButtonfront1
                interval: 200
                repeat: false
                onTriggered:{
                    buttonfront1.source = "../front.png"
                    
                }
            }
        
       }

     Button { //Back1 button
            id: back1
            x: 105
            y: 645
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                id: buttonback1
                source: "../back.png"
                
            }            
            
       onClicked: {
                buttonback1.source = "../backchanged.png"
                resetButtonback1.start()
                
            }

        Timer{
                id: resetButtonback1
                interval: 200
                repeat: false
                onTriggered:{
                    buttonback1.source = "../back.png"
                    
                }
            }

     }

     Button { //Left button
            id: left
            x: 10
            y: 622.5
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                id: leftbutton
                source: "../Left.png"
                
            }
        onClicked: {
                leftbutton.source = "../leftchanged.png"
                resetButtonleft.start()
                
            }

        Timer{
                id: resetButtonleft
                interval: 200
                repeat: false
                onTriggered:{
                    leftbutton.source = "../Left.png"
                    
                }
            }

        
     }
     Button { //Right button
            id: right
            x: 140
            y: 622.5
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 40
                height: 40
                radius: 20
            }
            
            contentItem: Image{
                id: buttonright
                source: "..//Right.png"
                
            }

        onClicked: {
                buttonright.source = "../rightchanged.png"
                resetButtonright.start()
                
            }

        Timer{
                id: resetButtonright
                interval: 200
                repeat: false
                onTriggered:{
                    buttonright.source = "../Right.png"
                    
                }
            }
        
     }

     CheckBox { //controller checkbox
        id: controller
        x: 195
        y: 600
        width : 150
        height : 20
        text: qsTr("Controller")
           
        indicator: Rectangle {  // Personaliza el indicador de la CheckBox
                width: 24
                height: 24
                radius: 4  // Esquinas redondeadas
                color: controller.checked ? "green" : "red"  // Cambia de color cuando está seleccionada
        }
        onToggled: {
            if (checked){
                    warnings_text.text = "Driving Mode Crontroller"
                    keyboard.checked = false
                    autonomus.checked = false
                } 
            }


    
     }    
     CheckBox { //keyboard checkbox
        id: keyboard
        x: 195
        y: 630
        width : 150
        height : 20
        text: qsTr("Keyboard")

        indicator: Rectangle {  // Personaliza el indicador de la CheckBox
            width: 24
            height: 24
            radius: 4  // Esquinas redondeadas
            color: keyboard.checked ? "green" : "red"  // Cambia de color cuando está seleccionada

        }
        onToggled: {
            if (checked){
                    warnings_text.text = "Driving Mode Keyboard"
                    autonomus.checked = false
                    controller.checked = false
                } 
            }
     }
     CheckBox {// auntonomus checkbox
        id: autonomus
        x: 195
        y: 660
        width : 150
        height : 20
        text: qsTr("Autonomus")
        
        indicator: Rectangle {  // Personaliza el indicador de la CheckBox
                width: 24
                height: 24
                radius: 4  // Esquinas redondeadas
                color: autonomus.checked ? "green" : "red"  // Cambia de color cuando está seleccionada
        }
        onToggled: {
            if (checked){
                    warnings_text.text = "Driving Mode Autonomus"
                    keyboard.checked = false
                    controller.checked = false
                } 
            }
     }
     Rectangle { // Sensors box
        id: sensors
        x: 1030
        y: 100
        width: 320
        height: 150
        opacity: 0.5
        color: "#1d1d1b"
        radius: 49

        TextArea{ // text area that shows the voltage
            x:10
            y:54
            width:280
            height:100
            id: sensors_text
            readOnly:true
            wrapMode: Text.WordWrap
            color:"#ffffff"
            font.styleName: "thin"
            font.bold: true
            font.pixelSize: 20
            text: "Click the sensor"
            opacity: 0.99

            }

        


     }


     Keys.onPressed: (event) => {
       if (event.key === Qt.Key_Return || event.key === Qt.Key_W) {
            front.clicked()
            
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_S) {
           back.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_Up){
            front1.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_Down){
            back1.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_Left){
            left.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_Right){
            right.clicked()
        }
}
    
     Connections {
        target: pyInterface
          
          function onActualizedVoltage(newVoltage) {
            sensors_text.text = "Voltage " + newVoltage;   
        }

          function onActualizedAmperage(newAmperage) {
            sensors_text.text = "Amperage " + newAmperage;   
        }

          function onActualizedCo(newCo) {
            sensors_text.text = "Co2 " + newCo; 
        }

          function onActualizedBattery(newBattery) {
            sensors_text.text = "Battery Left " + newBattery + "%" ; 
        }
    
    }}}
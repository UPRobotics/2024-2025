import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


ApplicationWindow { // Initialize main window
    visible: true
    width: 1920
    height: 1080
    title : "Up Robotics Movimiento"
    

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
        }
 

    Button { //Motor Id button
            id: change_motor_id
            x: 1000
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
                source: "../ID.png"
                
            }

            onClicked:{
                motors_menu.visible = !motors_menu.visible
                }
        
    }

    Rectangle{
        id : motor_id_background
        width: 40
        height: 25
        x:1060
        y:29
        color: "#000000"
        radius:5
     }
         
    TextInput{ // Text input that changes the motor id
            id: motor_id
            width: 40
            x: 1064
            y : 32
            color : "#ffffff"
            font.styleName: "Thin"
            text: String("000")
    }
    
    
    Rectangle{//motors_menu
        id: motors_menu
        width: 200
        height: 220
        x:780
        y:60
        color:"#b7aeae"
        opacity:0.6
        visible: false 
        radius: 15

        Button{
            id: banda_derecha
            x: 10
            y: 10
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 160
                height: 40
                radius: 20
            }

            contentItem: Image{
                source: "../motor_banda_derecha.png"
                
            }
            onClicked:{
                pyInterface.rightBand(motor_id.text)
                warnings.color ="#fb7118"
                notification_content.text = ("Right Band Motor ID Updated with value "+ motor_id.text+"\n")
                warnings_text.text += ("Right Band Motor ID Updated with value "+ motor_id.text+"\n")
                warnings.visible = !warnings.visible
                motors_menu.visible= !motors_menu.visible
                rightBand_info_data.text= motor_id.text
                resetNotification.start()

            }
            
        }

        Button{
            id: banda_izquierda
            x: 10
            y: 60
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 160
                height: 40
                radius: 20
            }

            contentItem: Image{
                source: "../motor_banda_izquierda.png"
                
            }

            onClicked:{
                pyInterface.leftBand(motor_id.text)
                warnings.color ="#fb7118"
                notification_content.text = ("Left Band Motor ID Updated with value " + motor_id.text)
                warnings_text.text += ("Left Band Motor ID Updated with value " + motor_id.text + "\n")
                warnings.visible = !warnings.visible
                leftBand_info_data.text= motor_id.text
                motors_menu.visible= !motors_menu.visible
                resetNotification.start()

            }
        }

        Button{
            id: flipper_delantero
            x: 10
            y: 110
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 160
                height: 40
                radius: 20
            }

            contentItem: Image{
                source: "../motor_fllipper_delantero.png"
                
            }

            onClicked:{
                pyInterface.frontFlipper(motor_id.text)
                warnings.color ="#fb7118"
                notification_content.text = ("Front Flipper Motor ID Updated with value "+ motor_id.text)
                warnings_text.text += ("Front Flipper Motor ID Updated with value "+ motor_id.text+"\n")
                warnings.visible = !warnings.visible
                motors_menu.visible= !motors_menu.visible
                frontFlipper_info_data.text= motor_id.text
                resetNotification.start()

            }
        }

        Button{ 
            id: flipper_trasero
            x: 10
            y: 160
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 160
                height: 40
                radius: 20
            }

            contentItem: Image{
                source: "../motor_flipper_trasero.png"
                
            }

            onClicked:{
                pyInterface.backFlipper(motor_id.text)
                warnings.color ="#fb7118"
                notification_content.text = ("Back Flipper Motor ID Updated with value "+ motor_id.text)
                warnings_text.text += ("Back Flipper Motor ID Updated with value "+ motor_id.text+"\n")
                warnings.visible = !warnings.visible
                backFlipper_info_data.text= motor_id.text
                motors_menu.visible= !motors_menu.visible
                resetNotification.start()

            }
        }
    }

    Button { // Mode button
            id: change_mode
            x: 100
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
                source: "../mode.png"
                
            }

            onClicked:{
                mode_menu.visible = !mode_menu.visible
                
                }
        
    }


    Rectangle{//mode_menu
        id: mode_menu
        width: 230
        height: 80
        x:150
        y:15
        color:"#000000"
        opacity:0.6
        visible: false 
        radius: 15

        Button{
            id: arm_mode_button
            x: 10
            y: 10
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 160
                height: 60
                radius: 20
            }

            contentItem: Image{
                source: "../arm_button.png"
                
            }
            onClicked:{
                mainWindow.targetPage = "Arm.qml"
            }
            
        }
        
        Button{
            id: movement_mode_button
            x: 80
            y: 10
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 160
                height: 60
                radius: 20
            }

            contentItem: Image{
                source: "../movement_button.png"
                
            }

            onClicked:{

            }
        }

        Button{
            id: home_button
            x: 150
            y: 10
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 160
                height: 60
                radius: 20
            }

            contentItem: Image{
                source: "../home_button.png"
                
            }

            onClicked:{
                mainWindow.targetPage = "Home.qml"

            }
        }

       
    }

         Rectangle{//voltage bar1
        id : voltage_bar1
        x: 1050
        y: 100
        color:"#edd01f"
        width: 35
        height:150
        radius: 10
        
     }

     Rectangle{// voltage bar2
        id : voltage_bar2
        x: 1050
        y: 100
        color:"#000000"
        width: 35
        height:50
        opacity: 0.5
        radius:10
     }

     Rectangle{//amperage bar1
        id : amperage_bar1
        x: 1100
        y: 100
        color:"#057fff"
        width: 35
        height:150
        radius:10
        
     }

     Rectangle{//amperage bar 2
        id : amperage_bar2
        x: 1100
        y: 100
        color:"#000000"
        width: 35
        height:50
        opacity: 0.5
        radius: 10
    
     }

    Rectangle {//motors ids
        id:info_motors
        width: 240
        height: 70
        x:1110
        y:5
        color: "#1d1d1b"
        radius: 20
        

    
     Grid {
        anchors.fill: parent
        anchors.margins: 5 // Margen interno
        rows: 2
        columns: 4
        spacing: 10 // Espacio entre los elementos

        Text {

                id: rightBand_info
                text: "Right Band"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id:rightBand_info_data
                text: "67"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: leftBand_info
                text: "Left Band"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id:leftBand_info_data
                text: "88"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: frontFlipper_info
                text: "Front Flipper"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: frontFlipper_info_data
                text: "67"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: backFlipper_info
                text: "Back Flipper"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: backFlipper_info_data
                text: "67"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

        
     }}

    Rectangle { // Genral INFO
        id:info
        width: 200
        height: 200
        x:1150
        y:100
        color: "#1d1d1b"
        radius: 20
        

        // Usamos un Grid para organizar el texto en 5 filas y 2 columnas
     Grid {
        anchors.fill: parent
        anchors.margins: 5 // Margen interno
        rows: 5
        columns: 2
        spacing: 10 // Espacio entre los elementos

            Text {

                id:latency
                text: "Latency"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id:latency_data
                text: "4 mss"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: battery
                text: "Battery"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id:battery_data
                text: "76%"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: speed
                text: "Speed"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id:speed_data
                text: "15 km/h"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: orientation
                text: "Orientation"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id:orientation_data
                text: "Ne"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id: lidar
                text: "Lidar"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }

            Text {

                id:lidar_data
                text: "Working"
                font.pixelSize: 14 // Tamaño de la fuente
                color: "#ffffff" // Color del texto
                font.bold: true // Texto en negrita
            }


            

            
    }
}

Button { //Voltage button
            id: voltage
            x: 1040
            y: 260
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
                
                }
        
     }

     Button { //Amperage button
            id: amperage
            x: 1090
            y: 260
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
            
                }
        
     }
        
    Rectangle{ //Notifications
            id: warnings
            x: 500
            y: 20
            width: 350
            height: 120
            color: "#c00a0a"
            radius: 15
            opacity: 0.5
            visible: false

            Text{
                id: notification_header 
                x: 130
                y: 10
                width: 200
                height: 60
                text: qsTr("Warning")
                font.pixelSize: 20
                font.styleName: "Thin"
                font.bold: true
                color: "White"
            }
             
            Text{
                id: notification_content
                x: 25
                y: 45
                width: 200
                height: 40
                text: qsTr("")
                font.pixelSize: 15
                font.styleName: "Thin"
                font.bold: true
                color: "White"
            }
    }

    Timer{ //Reset notification timer
        id: resetNotification
        interval: 1000
        repeat: false
        onTriggered:{
            warnings.visible = !warnings.visible
            warnings.color ="#c00a0a"
        }
    }

    Timer{//Clear Warnings timer
        id: clearWarnings
        interval: 60000
        repeat: true
        running: true
        onTriggered:{
            warnings_text.text = " "
        }

    }

    

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
                pyInterface.moveFront1()
                
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
                pyInterface.moveBack1()
                
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
                pyInterface.moveFront2()
                
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
                pyInterface.moveBack2()

                
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
                pyInterface.moveLeft()
                
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
                pyInterface.moveRight()
                
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

     Rectangle { // Warnings box
        id: warnings_box
        x: 10
        y: 85
        width: 350
        height: 300
        opacity: 0.5
        color: "#1d1d1b"
        radius: 40

        Text { // warnings box title
            id: warningstitle
            x: 100
            y: 24
            color: "White"
            text: qsTr("Warnings")
            font.pixelSize: 25
            font.styleName: "Thin"
            font.bold: true
        }
        
        TextArea{ // text area that shows the warning *need changes
            x:10
            y:54
            width:280
            height:220
            id: warnings_text
            readOnly:true
            wrapMode: Text.WordWrap
            placeholderText: "Welcome to UP Robotics Interface"
            color:"#ffffff"

            onTextChanged:{
                
            }

            

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
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_A){
            amperage.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_V){
            voltage.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_M){
            change_motor_id.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_R){
            banda_derecha.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_L){
            banda_izquierda.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_F){
            flipper_delantero.clicked()
        }else if (event.key === Qt.Key_Return || event.key === Qt.Key_B){
            flipper_trasero.clicked()
        }
    }
    

}

}

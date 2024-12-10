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

    Button { //Voltage button
            id: voltage
            x: 1230
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
                warnings.color ="#ffad00"
                notification_content.text = "Showing Voltage Data \n"
                warnings_text.text += "Showing Voltage Data \n"
                warnings.visible = !warnings.visible
                v_graph.visible =!v_graph.visible
                a_graph.visible = !a_graph.visible
                resetNotification.start()
                
                }
        
     }

    Button { //Amperage button
            id: amperage
            x: 1280
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
                warnings.color ="#01bedb"
                notification_content.text = "Showing Amperage Data \n"
                warnings_text.text += "Showing Amperage Data \n"
                warnings.visible = !warnings.visible
                a_graph.visible = !a_graph.visible
                v_graph.visible = !v_graph.visible
                resetNotification.start()
                }
        
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
                motors_menu.visible= !motors_menu.visible
                resetNotification.start()

            }
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

    Rectangle { // Voltage Graph
        id: v_graph
        x: 1030
        y: 100
        width: 310
        height: 250
        opacity: 0.5
        color: "#1d1d1b"
        radius: 49
        visible: true

        Rectangle { 
        id: v_graph2
        x: 10
        y: 10
        width: 290
        height: 210
        opacity: 0.5
        color: "#000000"
        radius: 40

        Rectangle{
            id: line
            x: 15
            y: 10
            width: 2
            height: 180
            color:"#ffffff"
        }

        Rectangle{
            id: line2
            x: 15
            y: 183
            width: 240
            height: 2
            color:"#ffffff"
        }

        Rectangle{
            id: graph_rectangle_1
            x: 20
            y: 10
            width: 10
            height: 172
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_2
            x: 35
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_3
            x: 50
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_4
            x: 65
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_5
            x: 80
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_6
            x: 95
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_7
            x: 110
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_8
            x: 125
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }
        Rectangle{
            id: graph_rectangle_9
            x: 140
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }

        Rectangle{
            id: graph_rectangle_10
            x: 155
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }
        Rectangle{
            id: graph_rectangle_11
            x: 170
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }
        Rectangle{
            id: graph_rectangle_12
            x: 185
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }
        Rectangle{
            id: graph_rectangle_13
            x: 200
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }
        Rectangle{
            id: graph_rectangle_14
            x: 215
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }
        Rectangle{
            id: graph_rectangle_15
            x: 230
            y: 44.4
            width: 10
            height: 137.8
            color:"#ffad00"
        }



        }

        Text{
            id: v_graph_text
            x:105
            y:225
            width: 50
            height: 40
            text: qsTr("Voltage Graph")
            font.pixelSize: 15
            font.styleName: "Thin"
            font.bold: true
            color: "White"

        }
    }

    Rectangle { // Amperage Graph
        id: a_graph
        x: 1030
        y: 100
        width: 310
        height: 250
        opacity: 0.5
        color: "#1d1d1b"
        radius: 49
        visible: false

        Rectangle { 
        id: a_graph2
        x: 10
        y: 10
        width: 290
        height: 210
        opacity: 0.5
        color: "#000000"
        radius: 40

        Rectangle{
            id: linea
            x: 15
            y: 10
            width: 2
            height: 180
            color:"#ffffff"
        }

        Rectangle{
            id: line2a
            x: 15
            y: 183
            width: 240
            height: 2
            color:"#ffffff"
        }

        Rectangle{
            id: grapha_rectangle_1
            x: 20
            y: 10
            width: 10
            height: 172
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_2
            x: 35
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_3
            x: 50
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_4
            x: 65
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_5
            x: 80
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_6
            x: 95
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_7
            x: 110
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_8
            x: 125
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }
        Rectangle{
            id: grapha_rectangle_9
            x: 140
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }

        Rectangle{
            id: grapha_rectangle_10
            x: 155
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }
        Rectangle{
            id: grapha_rectangle_11
            x: 170
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }
        Rectangle{
            id: grapha_rectangle_12
            x: 185
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }
        Rectangle{
            id: grapha_rectangle_13
            x: 200
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }
        Rectangle{
            id: grapha_rectangle_14
            x: 215
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }
        Rectangle{
            id: grapha_rectangle_15
            x: 230
            y: 44.4
            width: 10
            height: 137.8
            color:"#01bedb"
        }



        }

        Text{
            id: a_graph_text
            x:105
            y:225
            width: 50
            height: 40
            text: qsTr("Amperage Graph")
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

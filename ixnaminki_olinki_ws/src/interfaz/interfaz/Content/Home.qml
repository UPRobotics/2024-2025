import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15



ApplicationWindow { // Initialize main window
    id: mainWindow
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
        }

        Text { //title
           id: title1
           x: 480
           y: 100
           width: 500
           height: 100
           color: "#ffffff"
           text: qsTr("UP Robotics Control Interface")
            font.pixelSize: 30
            font.styleName: "Thin"
            font.bold: true
        }

        Text { //title
           id: title
           x: 580
           y: 200
           width: 500
           height: 100
           color: "#ffffff"
           text: qsTr("Select Mode:")
            font.pixelSize: 30
            font.styleName: "Thin"
            font.bold: true
        }


    Button { //Arm button
            id: arm
            x: 400
            y: 250
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 200
                height: 200
                radius: 20
            }
            
            contentItem: Image{
                source: "../arm_mode.png"
                
            }

            onClicked:{
                mainLoader.source = "Arm.qml"
                mainWindow.visible = !mainWindow.visible
                
            }
        
     }

    Button { //Movement Button
            id: movement
            x: 700
            y: 250
            text: qsTr("")
            flat: false
            background: Rectangle{
                color: "transparent"
                width: 200
                height: 2003
                radius: 20
            }
            
            contentItem: Image{
                source: "../movement_mode.png"
                
            }

            onClicked:{
                mainLoader.source = "Movement.qml"
                mainWindow.visible = !mainWindow.visible
                

            }
        
     }

    Loader{
        id:mainLoader
        anchors.fill: parent
    }

    Keys.onPressed: (event) => {
       if (event.key === Qt.Key_Return || event.key === Qt.Key_A) {
            arm.clicked()
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_M) {
           movement.clicked()
        }
    }
}}
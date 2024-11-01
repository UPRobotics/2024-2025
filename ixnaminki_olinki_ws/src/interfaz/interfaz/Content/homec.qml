import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow { // Initialize main window
    visible: true
    width: 1920
    height: 1080
    title: "Up Robotics Interface"
    
    Rectangle {
        width: parent.width
        height: parent.height

        Image { // Background
            anchors.fill: parent
            source: "../Background.png"
            fillMode: Image.PreserveAspectCrop
        }
    }

    Rectangle {  // Header
        id: header
        x: 0
        y: 0
        width: 1920
        height: 80
        color: "#857663"

        Image {  // Logo
            id: logo
            x: -16
            y: 0
            width: 100
            height: 80
            source: "../logo.png"
            fillMode: Image.PreserveAspectFit
        }      

        Switch { // On_Off Switch
            id: on_off_switch
            x: 150
            y: 18
            checked: false // Initial switch state
            background: Rectangle {
                color: on_off_switch.checked ? "#21641c" : "#64110f"
                radius: 30
            }
            onCheckedChanged: {
                if (checked) {
                    pyInterface.switchOn()
                    warnings_text.text += "Robot On\n"
                } else {
                    pyInterface.switchOff()
                    warnings_text.text += "Robot Off\n"
                }
            }
        }

        Text { // Text that changes when robot is on/off
            id: state
            x: 110
            y: 25
            font.pixelSize: 20
            font.styleName: "Thin"
            color: "#000000"
            text: on_off_switch.checked ? "On" : "Off" // text change when switch is clicked
        }

        Button {
            x: 1500
            y: 25
            width: 20
            height: 20
            color: "#ffffff"
        }
    }

    Rectangle { // Arm Control Box
        id: armcontrol
        x: 10
        y: 100
        width: 300
        height: 340
        opacity: 0.5
        color: "#1d1d1b"
        radius: 49

        Slider { // First Slider that controls x position
            id: control_x
            x: 25
            y: 96
            width: 250
            height: 30
            from: 0
            to: 150
            value: 90

            onValueChanged: {
                set_value_x.text = String(Math.round(value))
            }
        }

        TextInput { // Text input that changes the first slider value
            id: set_value_x
            width: 50
            x: 25
            y: 130
            color: "#ffffff"
            text: String(control_x.value)

            onTextChanged: {
                var newValue = parseFloat(text);
                if (!isNaN(newValue) && newValue >= control_x.from && newValue <= control_x.to) {
                    control_x.value = newValue;  // Sincronizar el Slider con el valor del TextInput
                }
            }
        }

        Slider { // Second slider that controls y position
            id: control_y
            x: 25
            y: 168
            width: 250
            height: 30
            from: 0
            to: 150
            value: 90

            onValueChanged: {
                set_value_y.text = String(Math.round(value))
            }
        }

        TextInput { // Text input that changes the second slider value
            id: set_value_y
            width: 50
            x: 25
            y: 202
            color: "#ffffff"
            text: String(control_y.value)

            onTextChanged: {
                var newValue = parseFloat(text);
                if (!isNaN(newValue) && newValue >= control_y.from && newValue <= control_y.to) {
                    control_y.value = newValue;  // Sincronizar el Slider con el valor del TextInput
                }
            }
        }

        Slider { // Third slider that controls z position
            id: control_z
            x: 25
            y: 240
            width: 250
            height: 30
            from: 0
            to: 150
            value: 90

            onValueChanged: {
                set_value_z.text = String(Math.round(value))
            }
        }

        TextInput { // Text input that changes the third slider value
            id: set_value_z
            width: 50
            x: 25
            y: 274
            color: "#ffffff"
            text: String(control_z.value)

            onTextChanged: {
                var newValue = parseFloat(text);
                if (!isNaN(newValue) && newValue >= control_z.from && newValue <= control_z.to) {
                    control_z.value = newValue; 
                }
            }
        }
        
        Button { // Button that extracts every slider value and connects it to python
            id: arm_changes
            x: 80
            y: 288
            text: qsTr("Apply Changes")
            flat: false
            background: Rectangle {
                color: "#857663"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 20
                font.styleName: "Thin"
            }

            onClicked: {
                pyInterface.getSlidersValues(control_x.value, control_y.value, control_z.value)
                warnings_text.text += "Robot Arm Position Updated\n"
            }
        }

        Button { // Button that requests sliders values from python
            id: arm_changes_in_terminal
            x: 20
            y: 288
            text: qsTr("Request Slider Values")
            flat: false
            background: Rectangle {
                color: "#857663"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: 20
                font.styleName: "Thin"
            }

            onClicked: {
                pyInterface.changeSlidersValues()
                warnings_text.text += "Change Arm Positions In Terminal\n"
            }

            // Function to update sliders from Python
            function updateSlidersv(valueX, valueY, valueZ) {
                control_x.value = valueX;
                control_y.value = valueY;
                control_z.value = valueZ;
                warnings_text.text += "Valores actualizados desde Python\n"
            }
        }

        Text { // Arm control box title
            id: arm_control_title
            x: 55
            y: 24
            color: "#857663"
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
        height: 230
        opacity: 0.5
        color: "#64110f"
        radius: 49

        Text { // Warnings box title
            id: warnings_title
            x: 70
            y: 24
            color: "White"
            text: qsTr("Warnings")
            font.pixelSize: 30
            font.styleName: "Thin"
            font.bold: true
        }

        TextArea { // Text area that shows the warning
            x: 10
            y: 54
            width: 280
            height: 100
            id: warnings_text
            readOnly: true
            wrapMode: Text.WordWrap
            placeholderText: "Welcome to UP Robotics Interface"
            color: "#ffffff"
        }
    }
}

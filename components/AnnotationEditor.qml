import QtQuick
import QtQuick.Controls

Rectangle {
    signal addAnnotation
    signal deleteAnnotation
    signal addAnnotationResponse

    height: textEditContainer.height + 10
    color: "transparent"

    Rectangle {
        id: textEditContainer
        width: parent.width - 10
        height: textEdit.height + 10
        radius: 7
        anchors {
            top: parent.top
            right: parent.right
        }
        border {
            color: "#e0e0e0"
            width: 1
        }
        color: "transparent"

        TextEdit {
            id: textEdit
            text: model.sentence
            font.pixelSize: 20
            width: parent.width - 10
            focus: true
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                margins: 5
            }
            padding: 3
            onTextChanged: model.sentence = text

            Shortcut {
                id: addAnnotationShortcut
                sequence: "Alt+Return"
                onActivated: addAnnotation()
            }

            Shortcut {
                id: deleteAnnotationShortcut
                sequence: "Alt+Del"
                onActivated: deleteAnnotation()
            }

            Shortcut {
                id: addAnnotationResponseShortcut
                sequence: "Ctrl+Alt+Return"
                onActivated: addAnnotationResponse()
            }
        }
    }
}

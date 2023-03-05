import QtQuick
import QtQuick.Controls

Rectangle {
    property string annotationLabel

    Label {
        id: questionLabel
        text: annotationLabel
        width: parent.width - 20
        font.pixelSize: 20
        anchors {
            left: parent.left
            margins: 10
        }
    }

    Rectangle {
        width: parent.width - 10
        height: questionEdit.height + 10
        radius: 5
        anchors {
            top: questionLabel.bottom
            right: parent.right
        }
        border {
            color: "gray"
            width: 1
        }
        color: "white"

        TextEdit {
            id: questionEdit
            font.pixelSize: 20
            width: parent.width - 10
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                margins: 5
            }
        }
    }
}

import QtQuick
import QtQuick.Controls

Rectangle {
    property url iconUrl

    width: parent.width
    height: Math.max(iconContainer.height, responseContainer.height)

    Rectangle {
        id: iconContainer
        width: 37
        height: 37
        anchors {
            right: responseContainer.left
            verticalCenter: parent.verticalCenter
        }

        Image {
            source: iconUrl
            anchors {
                fill: parent
                centerIn: parent
                top: parent.top
                margins: 5
            }
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: responseContainer
        width: parent.width - iconContainer.width - 10
        height: responseEdit.implicitHeight + 10
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        border {
            color: "#e0e0e0"
            width: 1
        }
        radius: 7

        TextEdit {
            id: responseEdit
            font.pixelSize: 20
            width: parent.width - 10
            anchors {
                fill: parent
                centerIn: parent
                margins: 5
                horizontalCenter: parent.horizontalCenter
            }
            padding: 3
        }
    }
}

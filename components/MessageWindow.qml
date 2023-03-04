import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    property string message
    property url iconUrl

    id: messageWindow
    flags: Qt.Dialog
    modality: Qt.ApplicationModal
    title: "Message Box"
    width: contentContainer.width + 20
    minimumWidth: contentContainer.width + 20
    height: (contentContainer.height + 20) + (button.height + 20)
    minimumHeight: (contentContainer.height + 20) + (button.height + 20)

    Rectangle {
        id: contentContainer
        width: iconContainer.width + textContainer.width
        height: Math.max(textContainer.height, iconContainer.height)

        anchors {
            top: parent.top
            left: parent.left
            margins: 10
        }

        Rectangle {
            id: iconContainer
            width: 32
            height: textContainer.height

            anchors {
                left: parent.left
            }

            Image {
                id: icon
                source: iconUrl
                fillMode: Image.PreserveAspectFit
                anchors {
                    fill: parent
                    centerIn: parent
                }
            }
        }

        Rectangle {
            id: textContainer
            width: messageText.implicitWidth + 20
            height: messageText.implicitHeight + 20

            anchors {
                left: iconContainer.right
            }

            Text {
                id: messageText
                text: message
                anchors {
                    fill: parent
                    centerIn: parent
                    margins: 10
                }
            }
        }
    }

    Button {
        id: button
        width: 64
        text: "OK"
        onClicked: {
            messageWindow.close()
        }

        anchors {
            bottom: parent.bottom
            right: parent.right
            margins: 10
        }
    }
}

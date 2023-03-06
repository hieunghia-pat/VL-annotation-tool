import QtQuick
import QtQuick.Controls

Rectangle {

    id: container

    width: parent.width
    height: Math.max(iconContainer.height, responseContainer.height) + 20

    Rectangle {
        id: iconContainer
        width: 37
        height: 37
        anchors {
            right: responseContainer.left
            verticalCenter: parent.verticalCenter
        }

        Image {
            source: "../media/down-right.png"
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
            bottomMargin: 5
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

    Rectangle {
        id: lineButtonContainer
        width: responseContainer.width - 10
        height: 5
        anchors {
            bottom: responseContainer.bottom
            horizontalCenter: responseContainer.horizontalCenter
        }
        color: "transparent"

        Row {
            anchors {
                centerIn: parent
            }
            spacing: 20

            Rectangle {
                id: addResponseIconContainer
                width: 16
                height: 16
                visible: false
                Image {
                    id: addResponseIcon
                    fillMode: Image.PreserveAspectFit
                    source: "../media/add-response.png"
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                }
                MouseArea {
                    id: addResponseIconMouseArea
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                }
            }

            Rectangle {
                id: deleteResponseIconContainer
                width: 16
                height: 16
                visible: false
                Image {
                    id: deleteResponseIcon
                    fillMode: Image.PreserveAspectFit
                    source: "../media/delete.png"
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                }

                MouseArea {
                    id: deleteResponseIconMouseArea
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                }
            }
        }

        MouseArea {
            id: lineButtonMouseArea
            hoverEnabled: true
            anchors {
                fill: parent
                centerIn: parent
            }
        }
    }

    Connections {
        target: lineButtonMouseArea

        function onEntered() {
            addResponseIconContainer.visible = true
            deleteResponseIconContainer.visible = true
        }

        function onExited() {
            addResponseIconContainer.visible = false
            deleteResponseIconContainer.visible = false
        }
    }
}

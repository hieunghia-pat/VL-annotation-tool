import QtQuick
import QtQuick.Controls

Rectangle {

    signal deleteAnnotationResponse

    id: container
    width: parent.width
    height: Math.max(iconContainer.height, responseContainer.height) + 20
    color: "transparent"

    Rectangle {
        id: iconContainer
        width: 37
        height: 37
        anchors {
            right: responseContainer.left
            verticalCenter: parent.verticalCenter
        }
        color: "transparent"

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
        color: "transparent"

        TextEdit {
            id: responseEdit
            text: model.response
            font.pixelSize: 20
            width: parent.width - 10
            anchors {
                fill: parent
                centerIn: parent
                margins: 5
                horizontalCenter: parent.horizontalCenter
            }
            padding: 3
            onTextChanged: model.response = text
        }

        Connections {
            target: container

            function onDeleteAnnotationResponse() {
                responseEdit.clear()
            }
        }
    }

    Rectangle {
        id: lineButtonContainer
        width: responseContainer.width - 10
        height: 7
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
                id: deleteResponseIconButton
                width: 16
                height: 16
                visible: false
                Image {
                    source: "../media/delete.png"
                    fillMode: Image.PreserveAspectFit
                    anchors {
                        centerIn: parent
                        fill: parent
                    }
                }
                MouseArea {
                    id: deleteResponseMouseArea
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                    onClicked: deleteAnnotationResponse()
                }
            }
        }

        MouseArea {
            id: lineButtonMouseArea
            hoverEnabled: true
            propagateComposedEvents: true
            anchors {
                fill: parent
                centerIn: parent
            }
        }
    }

    Connections {
        target: lineButtonMouseArea

        function onEntered() {
            deleteResponseIconButton.visible = true
        }

        function onExited() {
            deleteResponseIconButton.visible = false
        }
    }
}

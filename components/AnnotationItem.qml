import QtQuick
import QtQuick.Controls
import QtQml 2.3

Rectangle {

    property int annotationId

    id: annotationItemContainer
    width: annotationViewerContainer.width - 10
    height: annotationLabel.height + annotationContainer.height + responseContainer.height + 10

    radius: 7
    border {
        width: 1
        color: "#e0e0e0"
    }

    Rectangle {
        id: annotationLabel
        width: labelText.implicitWidth
        height: labelText.implicitHeight + 10
        Text {
            id: labelText
            anchors {
                fill: parent
                centerIn: parent
                top: parent.top
                margins: 5
            }
            text: "Annotation " + annotationId
        }
        color: "transparent"
    }

    Rectangle {
        id: topRightIconsContainer
        width: 80
        height: 25
        anchors {
            right: parent.right
            top: parent.top
        }

        color: "transparent"
        Row {
            id: iconsContainer
            anchors {
                fill: parent
                centerIn: parent
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
                margins: 5
            }

            spacing: 10

            Rectangle {
                id: addAnnotationIconContainer
                width: 16
                height: 16
                radius: 16
                Image {
                    source: "../media/add-annotation.png"
                    fillMode: Image.PreserveAspectFit
                    anchors {
                        fill: parent
                        centerIn: parent
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                color: "transparent"
                MouseArea {
                    id: addAnnotationIconMouseArea
                    hoverEnabled: true
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                }
            }

            Rectangle {
                id: deleteAnnotationIconContainer
                width: 16
                height: 16
                radius: 16
                Image {
                    source: "../media/delete-annotation.png"
                    fillMode: Image.PreserveAspectFit
                    anchors {
                        fill: parent
                        centerIn: parent
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                color: "transparent"
                MouseArea {
                    id: deleteAnnotationIconMouseArea
                    hoverEnabled: true
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                }
            }

            Rectangle {
                id: addAnnotationResponseIconContainer
                width: 16
                height: 16
                radius: 16
                Image {
                    source: "../media/down-left.png"
                    fillMode: Image.PreserveAspectFit
                    anchors {
                        fill: parent
                        centerIn: parent
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                color: "transparent"
                MouseArea {
                    id: addAnnotationResponseIconMouseArea
                    hoverEnabled: true
                    anchors {
                        fill: parent
                        centerIn: parent
                    }
                }
            }
        }
    }

    AnnotationEditor {
        id: annotationContainer
        width: parent.width - 5
        anchors {
            top: annotationLabel.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    ResponseAnnotationEditor {
        id: responseContainer
        width: parent.width - 5

        anchors {
            top: annotationContainer.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Connections {
        target: addAnnotationIconMouseArea

        function onEntered() {
            addAnnotationIconContainer.color = "#a6a6a6"
        }

        function onExited() {
            addAnnotationIconContainer.color = "transparent"
        }
    }

    Connections {
        target: deleteAnnotationIconMouseArea

        function onEntered() {
            deleteAnnotationIconContainer.color = "#a6a6a6"
        }

        function onExited() {
            deleteAnnotationIconContainer.color = "transparent"
        }
    }

    Connections {
        target: addAnnotationResponseIconMouseArea

        function onEntered() {
            addAnnotationResponseIconContainer.color = "#a6a6a6"
        }

        function onExited() {
            addAnnotationResponseIconContainer.color = "transparent"
        }
    }
}

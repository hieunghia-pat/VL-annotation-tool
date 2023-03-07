import QtQuick
import QtQuick.Controls
import QtQml 2.3

Rectangle {

    property int annotationId
    property int index

    signal addAnnotation(int index)
    signal deleteAnnotation(int index)
    signal addAnnotationResponse(int index)

    id: annotationItemContainer
    width: annotationViewerContainer.width - 10
    height: annotationLabel.height + annotationContainer.height
            + responseAnnotationContainer.height + 10

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

            Icon {
                id: addAnnotationIconContainer
                iconUrl: "../media/add-annotation.png"
                onSelected: addAnnotation(index)
            }

            Icon {
                id: deleteAnnotationIconContainer
                iconUrl: "../media/delete-annotation.png"
                onSelected: deleteAnnotation(index)
            }

            Icon {
                id: addAnnotationResponseIconContainer
                iconUrl: "../media/down-left.png"
                onSelected: addAnnotationResponse(index)
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

    Rectangle {
        id: responseAnnotationContainer
        anchors {
            top: annotationContainer.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width - 10
        height: responseAnnotationEditor.height

        ResponseAnnotationEditor {
            id: responseAnnotationEditor
            width: parent.width - 5
        }
    }
}

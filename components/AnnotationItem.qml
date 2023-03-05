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
        iconUrl: "../media/down-right.png"

        anchors {
            top: annotationContainer.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }
}

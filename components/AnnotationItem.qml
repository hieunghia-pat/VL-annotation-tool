import QtQuick
import QtQuick.Controls
import QtQml 2.3

GroupBox {
    id: annotationItemContainer
    title: "Annotation"
    width: annotationViewerContainer.width - 10
    height: 256

    AnnotationEditor {
        id: questionContainer
        annotationLabel: "Question"
        width: parent.width
        color: "white"
        anchors {
            top: parent.top
            margins: 5
            verticalCenter: parent.verticalCenter
        }
    }

    AnnotationEditor {
        id: answerContainer
        annotationLabel: "Answer"
        width: parent.width
        color: "white"
        anchors {
            top: questionContainer.bottom
            margins: 5
            verticalCenter: parent.verticalCenter
        }
    }
}

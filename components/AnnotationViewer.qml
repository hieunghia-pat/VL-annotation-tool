import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: annotationViewerContainer

    ListView {
        id: annotationView

        anchors {
            fill: parent
            top: parent.top
        }

        clip: true
        model: 1
        delegate: AnnotationItem {}

        spacing: 10
    }
}

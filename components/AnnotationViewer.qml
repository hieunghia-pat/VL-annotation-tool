import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: annotationViewerContainer

    ListView {
        id: annotationView

        anchors {
            fill: parent
            top: parent.top
            margins: 5
        }

        clip: true
        model: annotationModel
        delegate: AnnotationItem {
            
        }

        spacing: 20
    }
}

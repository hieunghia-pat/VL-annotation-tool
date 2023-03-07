import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: annotationViewerContainer

    property int total: 1
    property var backend

    ListView {
        id: annotationView

        anchors {
            fill: parent
            top: parent.top
            margins: 5
        }

        clip: true
        model: backend
        delegate: AnnotationItem {
            annotationId: index + 1
            index: index
            onAddAnnotation: index => backend.addAnnotation(index)

            onDeleteAnnotation: index => backend.deleteAnnotation(index)

            onAddAnnotationResponse: index => backend.addAnnotationResponse(
                                         index)
        }

        spacing: 20
    }
}

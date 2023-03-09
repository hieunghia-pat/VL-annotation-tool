import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: annotationViewerContainer

    property int total: 1

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
            onAddAnnotation: index => backend.addAnnotation(index)

            onDeleteAnnotation: index => backend.deleteAnnotation(index)

            onAddAnnotationResponse: index => backend.addAnnotationResponse(
                                         index)
        }

        spacing: 20
    }
}

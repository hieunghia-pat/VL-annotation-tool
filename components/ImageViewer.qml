import QtQuick 2.15

Rectangle {
    property url source
    property real currentScaleFactor: 1.

    id: imageViewerContainer

    function zoomImage(scaleFactor) {
        currentScaleFactor *= scaleFactor

        image.width *= currentScaleFactor
        image.height *= currentScaleFactor
    }

    function onZoomIn() {
        zoomImage(1.25)
    }

    function onZoomOut() {
        zoomImage(0.8)
    }

    function onFitScreen() {
        console.log("fit to the sceen")
    }

    Image {
        id: image
        source: parent.source
        anchors {
            centerIn: parent
            fill: parent
        }
        fillMode: Image.PreserveAspectFit
    }

    Connections {
        target: backend

        function onLoadedAnnotations() {
            image.source = backend.image
        }
    }
}

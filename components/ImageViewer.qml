import QtQuick 2.15

Item {
    property url source

    id: imageViewerContainer
    width: 0.5 * parent.width
    height: parent.height

    Image {
        source: parent.source
    }
}

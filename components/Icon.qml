import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    property url iconUrl
    signal selected

    id: container
    width: 16
    height: 16
    radius: 16
    visible: true
    Image {
        id: icon
        source: iconUrl
        fillMode: Image.PreserveAspectFit
        anchors {
            fill: parent
            centerIn: parent
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
    }
    color: "transparent"
    DropShadow {
        id: dropShadow
        anchors.fill: icon
        horizontalOffset: 1
        verticalOffset: 1
        radius: 3.0
        color: "#80000000"
        source: icon
        visible: false
    }
    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors {
            fill: parent
            centerIn: parent
        }
        onEntered: dropShadow.visible = true
        onExited: dropShadow.visible = false
        onClicked: selected()
    }
}

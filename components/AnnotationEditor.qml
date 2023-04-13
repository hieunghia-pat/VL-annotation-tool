import QtQuick
import QtQuick.Controls

Rectangle {
    signal selectedAnnotation(bool isFocus)

    height: textEditContainer.height + 10
    color: "transparent"

    Rectangle {
        id: textEditContainer
        width: parent.width - 10
        height: textEdit.height + 10
        radius: 7
        anchors {
            top: parent.top
            right: parent.right
        }
        border {
            color: "#e0e0e0"
            width: 1
        }
        color: "transparent"

        TextEdit {
            id: textEdit
            font.pixelSize: 20
            width: parent.width - 10
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                margins: 5
            }
            padding: 3
            onTextChanged: model.sentence = text
            onFocusChanged: isFocus => selectedAnnotation(isFocus)
            Component.onCompleted: {
                textEdit.focus = true
                textEdit.text = model.sentence
            }
        }
    }
}

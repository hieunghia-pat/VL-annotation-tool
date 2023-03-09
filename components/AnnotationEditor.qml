import QtQuick
import QtQuick.Controls

Rectangle {
    height: textEditContainer.height + 10

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

        TextEdit {
            id: textEdit
            text: model.sentence
            font.pixelSize: 20
            width: parent.width - 10
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                margins: 5
            }
            padding: 3
            onEditingFinished: model.sentence = text
        }
    }
}

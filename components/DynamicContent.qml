import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    property string content
    property url iconUrl

    id: container

    width: parent.width
    height: parent.height

    RowLayout {
        id: layout

        width: container.width
        height: container.height

//        IconImage {
//            source: iconUrl
//        }

        Text {
            text: content
        }
    }
}

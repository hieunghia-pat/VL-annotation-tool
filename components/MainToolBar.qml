import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ToolBar {
    id: mainToolBar

    property var openFolderDialog;
    property var saveFolderDialog;

    RowLayout {

        ToolButton {
            icon {
                source: "../media/open-folder.png"
            }
            onClicked: openFolderDialog.open()
        }

        ToolButton {
            icon {
                source: "../media/save-folder.png"
            }
            onClicked: saveFolderDialog.open()
        }

        ToolButton {
            icon {
                source: "../media/close-folder.png"
            }
        }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ToolBar {
    id: mainToolBar

    property var folderDialog;

    RowLayout {

        ToolButton {
            icon {
                source: "../media/open-folder.png"
            }
            onClicked: {
                folderDialog.title = "Select Folder to Open"
                folderDialog.acceptLabel = "Open"
                folderDialog.open()
            }
        }

        ToolButton {
            icon {
                source: "../media/save-folder.png"
            }
            onClicked: {
                folderDialog.title = "Select Folder to Save"
                folderDialog.acceptLabel = "Save"
                folderDialog.open()
            }
        }

        ToolButton {
            icon {
                source: "../media/close-folder.png"
            }
        }
    }
}

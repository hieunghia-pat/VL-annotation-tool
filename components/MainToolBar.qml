import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ToolBar {
    id: mainToolBar

    property var folderDialog

    RowLayout {

        ToolButton {

            icon {
                source: "../media/open-folder.png"
            }
            onClicked: {
                folderDialog.mode = "open"
                folderDialog.title = "Select Folder to Open"
                folderDialog.acceptLabel = "Open"
                folderDialog.open()
            }
        }

        ToolButton {
            id: saveButton
            enabled: false
            icon {
                source: "../media/save-folder.png"
            }
            onClicked: {
                backend.saveData()
                enabled: false
            }
        }

        ToolButton {
            icon {
                source: "../media/cut.png"
            }
            onClicked: {
                console.log("cut button")
            }
        }

        ToolButton {
            icon {
                source: "../media/copy.png"
            }
            onClicked: {
                console.log("copy button")
            }
        }

        ToolButton {
            icon {
                source: "../media/paste.png"
            }
            onClicked: {
                console.log("paste button")
            }
        }

        ToolButton {
            icon {
                source: "../media/zoom-in.png"
            }
            onClicked: {
                imageViewer.onZoomIn()
            }
        }

        ToolButton {
            icon {
                source: "../media/zoom-out.png"
            }
            onClicked: {
                imageViewer.onZoomOut()
            }
        }

        ToolButton {
            icon {
                source: "../media/fit-screen.png"
            }
            onClicked: {
                imageViewer.onFitScreen()
            }
        }

        ToolButton {
            icon {
                source: "../media/close-folder.png"
            }
        }

        ToolButton {
            icon {
                source: "../media/exit.png"
            }
            onClicked: {
                mainWindow.close()
            }
        }

        Connections {
            target: annotationModel

            function onDataChanged() {
                saveButton.enabled = true
            }
        }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15

MenuBar {
    id: mainMenuBar

    property var openFolderDialog;
    property url selectedFolderToOpen;

    property var saveFolderDialog;
    property url selectedFolderToSave;

    Menu {
        title: qsTr("&Folder")

        Action {
            text: qsTr("&Open")
            shortcut: StandardKey.Open
            icon {
                source: "../media/open-folder.png"
            }

            onTriggered: {
                openFolderDialog.open()
                mainMenuBar.selectedFolderToOpen = openFolderDialog.selectedFolder
            }
        }

        Action {
            text: qsTr("&Save")
            shortcut: StandardKey.Save
            icon {
                source: "../media/save-folder.png"
            }

            onTriggered: {
                saveFolderDialog.open()
                mainMenuBar.selectedFolderToSave = saveFolderDialog.selectedFolder
            }
        }

        Action {
            text: qsTr("&Close")
            shortcut: StandardKey.Close
            icon {
                source: "../media/close-folder.png"
            }
            onTriggered: console.log("Close Folder was clicked")
        }

        Action {
            text: qsTr("&Exit")
            shortcut: StandardKey.Exit
            icon {
                source: "../media/exit.png"
            }
            onTriggered: console.log("Exit Application was clicked")
        }
    }

    Menu {
        title: qsTr("&Edit")

        Action {
            text: qsTr("&Cut")
            shortcut: StandardKey.Cut
            icon {
                source: "../media/cut.png"
            }
            onTriggered: console.log("Exit Application was clicked")
        }

        Action {
            text: qsTr("&Copy")
            shortcut: StandardKey.Copy
            icon {
                source: "../media/copy.png"
            }
            onTriggered: console.log("Exit Application was clicked")
        }

        Action {
            text: qsTr("&Paste")
            shortcut: StandardKey.Paste
            icon {
                source: "../media/paste.png"
            }
            onTriggered: console.log("Exit Application was clicked")
        }

        Action {
            text: qsTr("&Add Annotation")
            shortcut: [Qt.Key_Control, Qt.Alt, Qt.Key_A]
            icon {
                source: "../media/add.png"
            }
            onTriggered: console.log("Exit Application was clicked")
        }

        Action {
            text: qsTr("&Remove Annotation")
            shortcut: [Qt.Key_Control, Qt.Alt, Qt.Key_Delete]
            icon {
                source: "../media/remove.png"
            }
            onTriggered: console.log("Exit Application was clicked")
        }
    }

    Menu {
        title: qsTr("About")

        Action {
            text: qsTr("&About")
            shortcut: [Qt.Key_Control, Qt.Alt, Qt.Key_Delete]
            icon {
                source: "../media/about.png"
            }
            onTriggered: console.log("Exit Application was clicked")
        }
    }
}

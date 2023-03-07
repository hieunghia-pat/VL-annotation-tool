import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs
import QtCore
import QtQuick.Layouts 1.3

import "components"

ApplicationWindow {
    id: mainWindow
    title: "Vision-Language Annotation Tool"
    width: 1080
    height: 720
    visible: true

    background: Rectangle {
        color: "white"
    }

    FolderDialog {
        id: folderDialog
        currentFolder: StandardPaths.standardLocations(
                           StandardPaths.DocumentsLocation)[0]
        onAccepted: {
            model.setSelectedFolderToOpen(currentFolder)
        }
    }

    MessageWindow {
        id: messageWindow
    }

    Connections {
        target: model

        function onOpenNewFolder() {
            messageWindow.message = "Opened a new folder"
            messageWindow.iconUrl = "../media/information.png"
            messageWindow.show()
        }

        function onOpenFolderError(message) {
            messageWindow.message = message
            messageWindow.iconUrl = "../media/error.png"
            messageWindow.show()
        }
    }

    menuBar: MainMenuBar {
        folderDialog: folderDialog
    }

    ImageViewer {
        id: imageViewer

        anchors {
            left: parent.left
        }

        width: parent.width / 2
        height: parent.height
    }

    AnnotationViewer {
        id: annotationViewer
        anchors {
            right: parent.right
        }
        width: parent.width / 2
        height: parent.height
        backend: model
    }

    header: MainToolBar {
        folderDialog: folderDialog
    }
}

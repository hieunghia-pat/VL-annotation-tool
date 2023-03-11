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

    DynamicFolderDialog {
        id: folderDialog
        currentFolder: StandardPaths.standardLocations(
                           StandardPaths.DocumentsLocation)[0]
        onAccepted: {
            backend.setSelectedFolderToOpen(currentFolder)
        }
    }

    MessageWindow {
        id: messageWindow
    }

    Connections {
        target: backend

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
        source: backend.image
    }

    AnnotationViewer {
        id: annotationViewer
        anchors {
            right: parent.right
        }
        width: parent.width / 2
        height: parent.height
    }

    header: MainToolBar {
        folderDialog: folderDialog
    }

    Shortcut {
        id: nextImageShorcut
        sequence: "Alt+right"
        onActivated: backend.nextImage()
        context: Qt.ApplicationShortcut
    }

    Shortcut {
        id: previousImageShorcut
        sequence: "Alt+left"
        onActivated: backend.previousImage()
        context: Qt.ApplicationShortcut
    }
}

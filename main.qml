import QtQuick 2.14
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import QtCore
import QtQuick.Layouts 1.15

import "components"

ApplicationWindow {
    id: mainWindow
    title: "Vision-Language Annotation Tool"
    width: 1080
    height: 720
    visible: true

    FolderDialog {
        id: openFolderDialog
        title: "Select Folder to Open Annotation"
        currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
    }

    FolderDialog {
        id: saveFolderDialog
        title: "Select Folder to Save Annotation"
        currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
    }

    menuBar: MainMenuBar {
        openFolderDialog: openFolderDialog
        saveFolderDialog: saveFolderDialog
    }

    Column {
        ImageViewer {

        }

        AnnotationViewer {

        }
    }

    header: MainToolBar {
        openFolderDialog: openFolderDialog
        saveFolderDialog: saveFolderDialog
    }
}

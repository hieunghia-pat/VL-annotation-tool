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
		function onOpenNewFolder(message) {
			messageWindow.message = "Opened a new folder"
			messageWindow.iconUrl = "../media/information.png"
			messageWindow.show()
		}
	}

	menuBar: MainMenuBar {
		folderDialog: folderDialog
	}

	Column {
		ImageViewer {}

		AnnotationViewer {}
	}

	header: MainToolBar {
		folderDialog: folderDialog
	}
}

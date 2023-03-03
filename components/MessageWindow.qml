import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
	property string message
	property url iconUrl

	id: messageWindow
	flags: Qt.Dialog
	modality: Qt.ApplicationModal
	title: "Message Box"
	maximumWidth: contentLayout.implicitWidth
	maximumHeight: mainLayout.implicitHeight
	minimumWidth: contentLayout.implicitWidth
	minimumHeight: mainLayout.implicitHeight

	ColumnLayout {
		id: mainLayout
		anchors {
			centerIn: parent
			fill: parent
		}

		RowLayout {
			id: contentLayout
			spacing: 2

			Rectangle {
				width: 32
				height: 32
				anchors {
					horizontalCenter: Layout.horizontalCenter
					fill: Layout.parent
					centerIn: Layout.parent
				}

				Image {
					source: iconUrl
					scale: Image.PreserveAspectFit
					anchors {
						fill: parent
						centerIn: parent
						margins: 5
					}
				}
			}

			Text {
				text: message
				anchors.horizontalCenter: Layout.horizontalCenter
				Layout.margins: 5
			}
		}

		Rectangle {
			width: contentLayout.implicitWidth
			height: button.implicitHeight
			anchors {
				centerIn: Layout.parent
				fill: Layout.parent
			}

			Button {
				id: button
				text: "Ok"
				onClicked: messageWindow.close()
				anchors {
					margins: 20
					right: parent.right
				}
			}
		}
	}
}

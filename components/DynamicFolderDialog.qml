import QtQuick 2.15
import QtQuick.Dialogs
import QtQuick.Controls 2.15

FolderDialog {
    function onDynamicallyAccepted(dynamicTitle, dynamicAcceptLabel) {
        title = title
        acceptLabel = acceptLabel
    }
}

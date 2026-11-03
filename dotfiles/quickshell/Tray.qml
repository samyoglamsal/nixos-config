import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

// StatusNotifier tray icons. Left-click activates the app.
RowLayout {
    spacing: 6

    Repeater {
        model: SystemTray.items

        delegate: Item {
            id: item

            required property var modelData

            implicitWidth: 18
            implicitHeight: 18
            Layout.alignment: Qt.AlignVCenter

            Image {
                anchors.fill: parent
                source: item.modelData.icon
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onClicked: item.modelData.activate()
            }
        }
    }
}

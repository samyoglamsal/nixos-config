import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

// Hyprland workspaces for one monitor, styled like the waybar version.
RowLayout {
    id: root

    Theme { id: theme }

    property string screenName: ""

    spacing: 4

    Repeater {
        model: Hyprland.workspaces.values
            .filter(ws => ws.monitor && ws.monitor.name === root.screenName)
            .sort((a, b) => a.id - b.id)

        delegate: Rectangle {
            id: ws

            required property var modelData
            readonly property var hws: modelData

            implicitWidth: label.implicitWidth + 16
            implicitHeight: theme.pillHeight
            radius: theme.radius
            color: hws.focused ? theme.darkBlue : (hws.active ? theme.bg2 : "transparent")
            border.width: hws.urgent ? 1 : 0
            border.color: theme.red

            Text {
                id: label
                anchors.centerIn: parent
                text: ws.hws.name
                font.family: theme.font
                font.pixelSize: theme.textSize
                font.bold: true
                color: ws.hws.focused ? theme.fg : (ws.hws.active ? theme.fg : theme.fgDim)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + ws.hws.id)
            }
        }
    }
}

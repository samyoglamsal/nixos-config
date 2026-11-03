import QtQuick
import QtQuick.Layouts

// A rounded status pill: optional icon followed by text.
Rectangle {
    id: root

    Theme { id: theme }

    property string icon: ""
    property string text: ""
    property color pillColor: theme.blue
    property color textColor: theme.dark
    property bool critical: false

    implicitWidth: row.implicitWidth + 20
    implicitHeight: theme.pillHeight
    radius: theme.radius
    color: critical ? theme.red : pillColor

    Behavior on color { ColorAnimation { duration: 150 } }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 8

        Text {
            visible: root.icon !== ""
            text: root.icon
            color: root.textColor
            font.family: theme.font
            font.pixelSize: theme.iconSize
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            visible: root.text !== ""
            text: root.text
            color: root.textColor
            font.family: theme.font
            font.pixelSize: theme.textSize
            Layout.alignment: Qt.AlignVCenter
        }
    }
}

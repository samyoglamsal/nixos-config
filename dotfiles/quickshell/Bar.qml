import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: bar

    required property var modelData
    screen: modelData

    Theme { id: theme }

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 34
    exclusiveZone: implicitHeight
    color: theme.bar

    SysInfo { id: sys }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    // Keeps the screen awake while toggled on.
    IdleInhibitor {
        id: inhibitor
        window: bar
        enabled: false
    }

    // Left: workspaces
    Workspaces {
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        screenName: bar.screen.name
    }

    // Center: date, logo, time
    RowLayout {
        anchors.centerIn: parent
        spacing: 4

        Pill {
            text: Qt.formatDateTime(clock.date, "MM-dd")
            pillColor: theme.clock
            textColor: theme.fg
        }
        Pill {
            icon: "󰣇"
            pillColor: theme.clock
            textColor: theme.blue
        }
        Pill {
            text: Qt.formatDateTime(clock.date, "HH:mm")
            pillColor: theme.clock
            textColor: theme.fg
        }
    }

    // Right: system pills, tray
    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Pill {
            icon: "󰋊"
            text: sys.diskFree
            pillColor: theme.green
        }
        Pill {
            icon: "󰆓"
            text: Math.round(sys.diskBusy) + "%"
            pillColor: theme.darkAqua
            critical: sys.diskBusy >= 80
            visible: true
        }
        Pill {
            icon: "󰔏"
            text: sys.temp
            pillColor: theme.orange
        }
        Pill {
            icon: "󰻠"
            text: sys.cpu
            pillColor: theme.blue
        }
        Pill {
            icon: "󰍛"
            text: sys.mem
            pillColor: theme.purple
        }

        AudioPill {
            bar: bar
            Layout.preferredHeight: theme.pillHeight
        }

        Pill {
            icon: sys.net.indexOf("wifi") === 0 ? "󰖩" : "󰈀"
            text: sys.net === "none" ? "Disconnected" :
                  sys.net.indexOf("wifi") === 0 ? sys.net.split(" ")[1] + "%" :
                  sys.net.split(" ")[1]
            pillColor: theme.yellow
        }

        Pill {
            visible: sys.mpd !== "off" && sys.mpd !== ""
            icon: sys.mpd.indexOf("play|") === 0 ? "󰐊" : "󰏤"
            text: sys.mpd.split("|").slice(1).join("|")
            pillColor: theme.darkBlue
        }

        Pill {
            icon: inhibitor.enabled ? "󰅶" : "󰒲"
            text: ""
            pillColor: inhibitor.enabled ? theme.orange : theme.bg2
            textColor: inhibitor.enabled ? theme.dark : theme.fg
            MouseArea {
                anchors.fill: parent
                onClicked: inhibitor.enabled = !inhibitor.enabled
            }
        }

        Tray {}
    }
}

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

// Default output volume. Scroll to adjust, left-click for a slider popup, right-click to mute.
Item {
    id: root

    Theme { id: theme }

    // The PanelWindow this pill lives in, used as the popup anchor.
    required property var bar

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property real volume: sink && sink.audio ? sink.audio.volume : 0
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false

    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    // Pipewire only exposes volume for nodes that are tracked.
    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    function setVolume(v) {
        if (root.sink && root.sink.audio)
            root.sink.audio.volume = Math.max(0, Math.min(1.5, v));
    }

    Pill {
        id: pill
        anchors.fill: parent
        pillColor: theme.aqua
        icon: root.muted ? "󰝟" : (root.volume < 0.34 ? "󰕿" : (root.volume < 0.67 ? "󰖀" : "󰕾"))
        text: root.muted ? "muted" : Math.round(root.volume * 100) + "%"
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                if (root.sink && root.sink.audio)
                    root.sink.audio.muted = !root.muted;
            } else {
                popup.visible = !popup.visible;
            }
        }
        onWheel: wheel => {
            root.setVolume(root.volume + (wheel.angleDelta.y > 0 ? 0.05 : -0.05));
        }
    }

    PopupWindow {
        id: popup

        visible: false
        color: "transparent"
        implicitWidth: 280
        implicitHeight: 110

        anchor.window: root.bar
        anchor.rect.x: popupX()
        anchor.rect.y: root.bar.implicitHeight + 4

        // Center the dropdown under the pill, clamped to the bar's width.
        function popupX() {
            // Read the layout properties so the binding re-runs when the pill moves.
            const deps = [root.x, root.width, root.parent ? root.parent.x : 0];
            const pillX = root.mapToItem(null, root.width / 2, 0).x;
            const x = pillX - popup.implicitWidth / 2;
            return Math.max(0, Math.min(x, root.bar.width - popup.implicitWidth));
        }

        Rectangle {
            anchors.fill: parent
            radius: 6
            color: theme.bar
            border.width: 1
            border.color: theme.bg2

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 10

                Text {
                    Layout.fillWidth: true
                    text: root.sink ? root.sink.description : "No output device"
                    color: theme.fg
                    font.family: theme.font
                    font.pixelSize: 13
                    elide: Text.ElideRight
                }

                Rectangle {
                    id: track
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                    radius: 5
                    color: theme.bg2

                    Rectangle {
                        width: track.width * Math.min(1, root.volume)
                        height: parent.height
                        radius: 5
                        color: theme.aqua
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: mouse => root.setVolume(mouse.x / track.width)
                        onPositionChanged: mouse => {
                            if (pressed)
                                root.setVolume(mouse.x / track.width);
                        }
                    }
                }

                Text {
                    text: (root.muted ? "Muted" : Math.round(root.volume * 100) + "%")
                    color: theme.fgDim
                    font.family: theme.font
                    font.pixelSize: 13
                }
            }
        }
    }
}

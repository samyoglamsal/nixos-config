import QtQuick

// Gruvbox dark palette and shared sizing. Each component creates its own instance.
QtObject {
    readonly property color bar: "#1d2021"
    readonly property color clock: "#3c3836"
    readonly property color bg2: "#504945"
    readonly property color fg: "#ebdbb2"
    readonly property color fgDim: "#a89984"
    readonly property color dark: "#1d2021"

    readonly property color red: "#fb4934"
    readonly property color green: "#b8bb26"
    readonly property color yellow: "#fabd2f"
    readonly property color blue: "#83a598"
    readonly property color darkBlue: "#458588"
    readonly property color purple: "#d3869b"
    readonly property color aqua: "#8ec07c"
    readonly property color darkAqua: "#689d6a"
    readonly property color orange: "#fe8019"

    readonly property string font: "CaskaydiaCove Nerd Font"
    readonly property int textSize: 16
    readonly property int iconSize: 22
    readonly property int radius: 0
    readonly property int pillHeight: 26
}

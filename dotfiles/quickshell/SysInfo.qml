import Quickshell
import Quickshell.Io
import QtQuick

// Polls the system stats shown in the bar. Each metric is a small script or command.
Item {
    id: sys

    visible: false

    property string cpu: "--"
    property string mem: "--"
    property string diskFree: "--"
    property string temp: "--"
    property string net: "none"
    property string mpd: "off"
    property real diskBusy: 0
    property real diskWrite: 0

    property var _prevCpu: null
    property var _prevDisk: null
    property real _prevDiskT: 0

    function poll(proc) {
        if (!proc.running)
            proc.running = true;
    }

    Process {
        id: cpuProc
        command: ["bash", Quickshell.shellDir + "/scripts/cpu.sh"]
        stdout: StdioCollector {
            id: cpuOut
            onStreamFinished: {
                const parts = cpuOut.text.trim().split(" ").map(Number);
                if (parts.length < 2) return;
                const idle = parts[0], total = parts[1];
                if (sys._prevCpu) {
                    const dIdle = idle - sys._prevCpu[0];
                    const dTotal = total - sys._prevCpu[1];
                    if (dTotal > 0)
                        sys.cpu = Math.round(100 * (1 - dIdle / dTotal)) + "%";
                }
                sys._prevCpu = [idle, total];
            }
        }
    }

    Process {
        id: diskProc
        command: ["bash", Quickshell.shellDir + "/scripts/disk.sh"]
        stdout: StdioCollector {
            id: diskOut
            onStreamFinished: {
                const parts = diskOut.text.trim().split(" ").map(Number);
                if (parts.length < 2) return;
                const busy = parts[0], sectors = parts[1];
                const now = Date.now();
                if (sys._prevDisk) {
                    const dt = now - sys._prevDiskT;
                    if (dt > 0) {
                        sys.diskBusy = Math.max(0, Math.min(100, 100 * (busy - sys._prevDisk[0]) / dt));
                        sys.diskWrite = Math.max(0, (sectors - sys._prevDisk[1]) * 512 / 1e6 / (dt / 1000));
                    }
                }
                sys._prevDisk = [busy, sectors];
                sys._prevDiskT = now;
            }
        }
    }

    Process {
        id: memProc
        command: ["bash", Quickshell.shellDir + "/scripts/mem.sh"]
        stdout: StdioCollector {
            id: memOut
            onStreamFinished: sys.mem = memOut.text.trim() + "G"
        }
    }

    Process {
        id: tempProc
        command: ["sh", "-c", "cat /sys/class/hwmon/hwmon2/temp1_input"]
        stdout: StdioCollector {
            id: tempOut
            onStreamFinished: {
                const raw = parseInt(tempOut.text.trim());
                sys.temp = isNaN(raw) ? "--" : Math.round(raw / 1000) + "°C";
            }
        }
    }

    Process {
        id: netProc
        command: ["bash", Quickshell.shellDir + "/scripts/network.sh"]
        stdout: StdioCollector {
            id: netOut
            onStreamFinished: sys.net = netOut.text.trim()
        }
    }

    Process {
        id: mpdProc
        command: ["python3", Quickshell.shellDir + "/scripts/mpd.py"]
        stdout: StdioCollector {
            id: mpdOut
            onStreamFinished: sys.mpd = mpdOut.text.trim()
        }
    }

    Process {
        id: dfProc
        command: ["sh", "-c", "df -h --output=avail $HOME | tail -1 | tr -d ' '"]
        stdout: StdioCollector {
            id: dfOut
            onStreamFinished: sys.diskFree = dfOut.text.trim()
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            sys.poll(cpuProc);
            sys.poll(diskProc);
            sys.poll(memProc);
            sys.poll(tempProc);
            sys.poll(netProc);
            sys.poll(mpdProc);
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: sys.poll(dfProc)
    }
}

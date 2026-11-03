#!/usr/bin/env python3
# Prints "play|<track>", "pause|<track>", "stop|" or "off" by talking to MPD on localhost:6600.
import socket
import sys


def command(f, line):
    f.write((line + "\n").encode())
    f.flush()
    fields = {}
    while True:
        raw = f.readline().decode().rstrip("\n")
        if raw == "" or raw.startswith("OK") or raw.startswith("ACK"):
            break
        if ": " in raw:
            key, value = raw.split(": ", 1)
            fields[key] = value
    return fields


def main():
    try:
        sock = socket.create_connection(("127.0.0.1", 6600), timeout=1)
    except OSError:
        print("off")
        return 0

    with sock:
        f = sock.makefile("rwb")
        f.readline()  # greeting: "OK MPD <version>"
        status = command(f, "status")
        song = command(f, "currentsong")
        command(f, "close")

    state = status.get("state", "stop")
    if state == "stop":
        print("stop|")
        return 0

    artist = song.get("Artist", "")
    title = song.get("Title", song.get("file", ""))
    track = f"{artist} - {title}" if artist else title
    if len(track) > 40:
        track = track[:39] + "…"
    print(f"{state}|{track}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

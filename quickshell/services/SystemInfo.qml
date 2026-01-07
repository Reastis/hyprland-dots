pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick


Singleton {
  id: root
  property string locale
  property string distro
  property string kbLayout
  property list<string> kbLayouts


  Process {
    id: updateKbLayout
    running: true
    command: ["sh", "-c", "hyprctl devices -j"]
    stdout: StdioCollector {
      onStreamFinished: {
        const jsonData = JSON.parse(data);
        const mainKb = jsonData["keyboards"].find(keyboard => keyboard["main"] == true);
        root.kbLayouts = mainKb["layout"].split(',');
        root.kbLayout = mainKb["active_keymap"].slice(0,3);
      }
    }
  }

  Connections {
    target: Hyprland
    function onRawEvent(event: HyprlandEvent) {
      if (event.name == "activelayout") {
        updateKbLayout.running = true
        console.log("Layout change")
      }
    }
  }
}


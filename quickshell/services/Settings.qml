pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.common

Singleton {
  id: root

  property bool isLoaded: false

  property string shellTitle: "delta-shell"
  property string configDir: `${Quickshell.env("HOME") || Quickshell.env("XDG_CONFIG_HOME")}/.config/${shellTitle}/`
  property string configFile: "config.json"
  property var config: jsonFileAdapter

  signal loaded
  signal reloaded

  FileView {
    id: viewAdapter
    path: configDir + configFile
    printErrors: true
    watchChanges: true
    onFileChanged: this.reload()
    adapter: jsonFileAdapter
    onAdapterUpdated: writeAdapter()

    onLoaded: function () {
      if (!root.isLoaded) {
        root.isLoaded = true;
        root.loaded();
      }
      else {
        root.reloaded();
      }
  }

  }
  JsonAdapter {
    id: jsonFileAdapter
    property JsonObject barSettings: JsonObject {
      property string mode: "floating" // solid/floating/empty/framed/docked
      property string anchor: "top"
      property real barSizeHorizontal: 32
      property real barSizeVertical: 45
      property real marginsVertical: Appearance.margins.marginL
      property real marginsHorizontal: Appearance.margins.marginM
      property real frameMargin: Appearance.margins.marginM
      property real borderThickness: 12
      property real outerFrameRadius: 12
      property real innerFrameRadius: 24
    }
  }
}

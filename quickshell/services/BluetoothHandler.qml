pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io

Singleton {
  id:root
  property bool enabled: Bluetooth.defaultAdapter?.enabled ?? false
  property var devices: Bluetooth.devices
  property bool searching: Bluetooth.adapters.values.some(adapter => adapter.discovering)
  property bool connected: devices.values.some(device => device.connected)
  property string symbolName: "bluetooth-off"
  onEnabledChanged: getSymbolName()
  onConnectedChanged: getSymbolName()
  onSearchingChanged: getSymbolName()
  function getSymbolName() {
    switch (enabled) {
      case (false):
        symbolName = "bluetooth-off";
        break;
      case (searching):
        symbolName = "bluetooth";
        break;
      case (connected):
        symbolName = "bluetooth-connected";
        break;
      case (true):
        symbolName = "bluetooth";
        break;
      }
  }
}

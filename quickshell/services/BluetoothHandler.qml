pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io

Singleton {
  id:root
  property bool enabled: Bluetooth.defaultAdapter?.enabled
  property var devices: Bluetooth.devices
  property bool searching: Bluetooth.adapters.values.some(adapter => adapter.discovering)
  property bool connected: devices.values.some(device => device.connected)
  property string symbolName: "bluetooth_disabled"
  onEnabledChanged: getSymbolName()
  onConnectedChanged: getSymbolName()
  onSearchingChanged: getSymbolName()
  function getSymbolName() {
    console.log(devices)
    let symbolName = "";
    switch (enabled) {
      case (false):
        symbolName = "bluetooth_disabled";
        break;
      case (searching):
        symbolName = "bluetooth_searching";
        break;
      case (connected):
        symbolName = "bluetooth_connected";
        break;
      case (true):
        symbolName = "bluetooth";
        break;
      }
      root.symbolName = symbolName;
  }
}

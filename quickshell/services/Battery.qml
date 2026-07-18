pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.common

Singleton {
  id: root
  property bool available: UPower.displayDevice.isLaptopBattery
  property bool isCharging: !UPower.onBattery
  property real percentage: UPower.displayDevice.percentage
  property var icons: IconMap.tablerIcons
  property string symbolName: "battery-vertical-off"
  onIsChargingChanged: getSymbolName()
  onPercentageChanged: getSymbolName()
  function getSymbolName() {
    let charge = Math.round(percentage*100)
    let symbolName = ""
    switch (!isCharging)
    {
      case (false):
        symbolName = "plug-connected";
        break;
      case (charge <= 5):
        symbolName = "battery-vertical-exclamation";
        break;
      case (charge <= 25):
        symbolName = "battery-vertical-1";
        break;
      case (charge <= 50):
        symbolName = "battery-vertical-2";
        break;
      case (charge <= 75):
        symbolName = "battery-vertical-3";
        break;
      case (charge <= 100):
        symbolName = "battery-vertical-4";
        break;
    }
    root.symbolName = symbolName;
  }
}

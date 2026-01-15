pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
  id: root
  property bool available: UPower.displayDevice.isLaptopBattery
  property bool isCharging: !UPower.onBattery
  property real percentage: UPower.displayDevice.percentage
  property string symbolName: "battery_unknown"
  onIsChargingChanged: getSymbolName()
  onPercentageChanged: getSymbolName()
  function getSymbolName() {
    let charge = Math.round(percentage*100)
    let symbolName = ""
    switch (!isCharging)
    {
      case (false):
        symbolName = "bolt";
        break;
      case(charge <= 15):
        symbolName = "battery_alert";
        break;
      case (charge <= 30):
        symbolName = "battery_2_bar";
        break;
      case (charge <= 45):
        symbolName = "battery_3_bar";
        break;
      case (charge <= 60):
        symbolName = "battery_4_bar";
        break;
      case (charge <= 85):
        symbolName = "battery_5_bar";
        break;
      case (charge <= 90):
        symbolName = "battery_6_bar";
        break;
      case (charge > 90):
        symbolName = "battery_full";
        break;
    }
    root.symbolName = symbolName;
  }
}

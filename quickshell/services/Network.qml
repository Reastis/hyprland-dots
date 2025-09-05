pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
  id:root
  property bool isConnected: true
  property bool ethernet: false
  property bool wifi: false
  property string networkName: ""
  property string symbolName: "signal_wifi_statusbar_not_connected"
  property int networkStrength
  property int reloadInterval: 1000

  function updateSymbolName() {
    symbolName = !isConnected? "signal_wifi_statusbar_not_connected" :
      ethernet? "lan" :
      wifi? networkStrength >= 75? "signal_wifi_4_bar" :
      networkStrength >= 50? "network_wifi_3_bar" :
      networkStrength >= 25? "network_wifi_2_bar" :
      networkStrength != 0? "network_wifi_1_bar": "signal_wifi_0_bar" :
      "cell_tower"
    root.symbolName = symbolName
  }

  Timer {
    interval:10
    running:true
    repeat:true
    onTriggered:{
      updateNetworkCredentials.running = true
      updateNetworkName.running = true
      if (root.wifi = true){
        updateNetworkStrength.running = true
      }
      if (!root.ethernet && symbolName != "lan"){
        updateSymbolName()
      }
      interval = reloadInterval
    }
  }
  
  Process {
    id: updateNetworkCredentials
    running: true
    command: ["sh", "-c", "nmcli -t -f NAME,TYPE,DEVICE c show --active"]
    stdout: SplitParser {
      onRead: data => {
        if (data.includes("wireless")) {
          root.wifi= true
        }
        else if (data.includes("ethernet")) {
          root.ethernet = true
        }
        if (root.wifi || root.ethernet) {
          root.isConnected = true
        }
      }
    }
  }
  Process {
    id: updateNetworkName
    running: true
    command: ["sh", "-c", "nmcli -t -f NAME c show --active| head -1"]
    stdout: SplitParser {
      onRead: data => {
        root.networkName = data;
      }
    }
  }
  Process {
    id: updateNetworkStrength
    running: true
    command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL device wifi|awk '/^\*/{print $2}' "]
    stdout: SplitParser {
      onRead: data => {
        networkStrength = parseInt(data);
      }
    }
  }
}

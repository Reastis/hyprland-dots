pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
  id:root
  property bool isConnected: false
  property bool ethernet: false
  property bool wifi: false
  property string networkName: ""
  property string symbolName: "network-off"
  property int networkStrength
  property int reloadInterval: 1000

  function updateSymbolName() {
    symbolName = !isConnected? "network-off" :
      ethernet? "network" :
      wifi? networkStrength >= 75? "wifi" :
      networkStrength >= 50? "wifi-2" :
      networkStrength >= 25? "wifi-1" : "wifi-0" : "antenna-off"
  }

  Timer {
    interval:10
    running:true
    repeat:true
    onTriggered:{
      updateNetworkConnection.running = true
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
    id: updateNetworkConnection
    running: true
    command: ["sh", "-c", " nmcli -g NAME,TYPE,DEVICE c show --active"]
    stdout: StdioCollector {
      onStreamFinished: {
        let connectedNetworks = text.trim().split('\n').map(conn => {
          const content = conn.split(":");
          return {
            name: content[0],
            type: content[1],
            device: content[2],
          }
        });
        root.wifi = connectedNetworks.some(network => network.type.includes("wireless"));
        root.ethernet = connectedNetworks.some(network => network.type.includes("ethernet"));
        root.isConnected = root.wifi || root.ethernet? true : false
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
    command: ["sh", "-c", "nmcli -t -f IN-USE,SIGNAL device wifi|awk -F: '/^\\*:/{ print $2}'"]
    stdout: SplitParser {
      onRead: data => {
        networkStrength = parseInt(data);
      }
    }
  }
}

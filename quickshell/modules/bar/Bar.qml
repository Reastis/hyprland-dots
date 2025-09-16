import QtQuick
import QtQuick.Layouts
import Quickshell

Scope {
  id: bar
  PanelWindow {
    id: root
    implicitHeight: 30
    mask: Region {
      item: barContent
    }
    margins {
      top: 3
      left: 3
      right: 3
    }
    anchors {
      left: true
      top: true
      right: true
    }
    color: "transparent"
    Item {
      id: barContent
      implicitHeight: 30
      height: 30
      anchors {
        left: parent.left
        top: parent.top
        right: parent.right
      }
      Rectangle {
        id: barBackground
        anchors {
          fill: parent
        }
        color: "transparent"
        radius: 12
      }
      RowLayout {
        id: barSectionLeft
        implicitHeight: 30
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }
        spacing: 4
        BarGroup {
          Workspaces {}
        }
      }
      RowLayout {
        id: barSectionCenter
        implicitHeight: 30
        anchors {
          horizontalCenter: parent.horizontalCenter
          top: parent.top
          bottom: parent.bottom
        }
        BarGroup {
          Clock {}
        }
      }
      RowLayout {
        id: barSectionRight
        implicitHeight:30
        anchors {
          right: parent.right
          top: parent.top
          bottom: parent.bottom
        }
        spacing:4
        BarGroup {
          BatteryIndicator{}
          BluetoothIndicator{}
          NetworkIndicator{}
        }
      }  
    }
  }
}

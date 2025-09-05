import QtQuick
import QtQuick.Layouts
import Quickshell

Scope {
  id: bar
  PanelWindow {
    id: barRoot
    implicitHeight: 40
    mask: Region {
      item: barContent
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
        color: "gray"
        radius: 12
      }
      RowLayout {
        implicitHeight:30
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
        implicitHeight:30
        anchors {
          right: parent.right
          top: parent.top
          bottom: parent.bottom
        }
        spacing:4
        BarGroup {
          BatteryIndicator{}
          NetworkIndicator{}
        }
      }  
    }
  }
}

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
Scope {
  id: bar
  // property string test: SystemInfo.kbLayout
  PanelWindow {
    id: root
    implicitHeight: 32
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
      implicitHeight: root.implicitHeight
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
        implicitHeight: barContent.implicitHeight
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
        implicitHeight: barContent.implicitHeight
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
        implicitHeight:barContent.implicitHeight
        anchors {
          right: parent.right
          top: parent.top
          bottom: parent.bottom
        }
        spacing:4
        BarGroup {
          BatteryIndicator{}
        }
        BarGroup {
          VolumeIndicator{}
          LanguageIndicator{}
          BluetoothIndicator{}
          NetworkIndicator{}
        }
      }
    }
  }
}

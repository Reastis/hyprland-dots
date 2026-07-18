import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.services
import qs.modules.widgets


Item {
  id: root

  anchors.fill: parent

  required property bool isHorizontal
  required property bool anchor

  Loader {
    anchors.fill: parent
    sourceComponent: root.isHorizontal? horizontalBarContent : verticalBarContent
  }
  Component {
    id: horizontalBarContent
    Item {
      anchors.fill: parent

      RowLayout {
        id: barSectionLeft
        implicitHeight: root.implicitHeight
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }
        spacing: 4
        BarGroup {
          Workspaces { isHorizontal: root.isHorizontal }
        }
      }
      RowLayout {
        id: barSectionCenter
        implicitHeight: root.implicitHeight
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
        implicitHeight: root.implicitHeight
        anchors {
          right: parent.right
          top: parent.top
          bottom: parent.bottom
        }
        spacing: 4
        BarGroup {
          SysTrayIndicator {}
        }
        BarGroup {
          BatteryIndicator {}
        }
        BarGroup {
          VolumeIndicator {}
          LanguageIndicator {}
          BluetoothIndicator {}
          NetworkIndicator {}
        }
      }
    }
  }
  Component {
    id: verticalBarContent
    Item {
      anchors.fill: parent

      ColumnLayout {
        id: barSectionLeft
        implicitWidth: root.implicitWidth
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
        }
        spacing: 4
        BarGroup {
          isHorizontal: false
          Workspaces { isHorizontal: root.isHorizontal }
        }
      }
      ColumnLayout {
        id: barSectionCenter
        implicitWidth: root.implicitWidth
        anchors {
          verticalCenter: parent.verticalCenter
          left: parent.left
          right: parent.right
        }
        BarGroup {
          isHorizontal: false
          Clock {
            isHorizontal: false
          }
        }
      }
      ColumnLayout {
        id: barSectionRight
        implicitWidth: root.implicitWidth
        anchors {
          bottom: parent.bottom
          left: parent.left
          right: parent.right
        }
        spacing: 4
        BarGroup {
          isHorizontal: false
          SysTrayIndicator {}
        }
        BarGroup {
          isHorizontal: false
          BatteryIndicator {}
        }
        BarGroup {
          isHorizontal: false
          VolumeIndicator {}
          LanguageIndicator {}
          BluetoothIndicator {}
          NetworkIndicator {}
        }
      }
    }
  }
}

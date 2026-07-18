import qs.services
import qs.modules.widgets
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Item {
  implicitHeight: content.height
  implicitWidth: content.width
  opacity: SysTray.trayItems.length > 0? 1 : 0
  property list<var> trayItems: SysTray.trayItems

  Row {
    id: content
    anchors.centerIn: parent
    spacing: 4
    Repeater {
      anchors.centerIn: parent
      model: ScriptModel {
        values: trayItems
      }
      delegate: Item {
        required property var modelData
        implicitWidth: 24
        implicitHeight: 24
        IconImage {
          anchors.centerIn: parent
          implicitSize: parent.width
          source: modelData.icon
        }
      }
    }
  }
}

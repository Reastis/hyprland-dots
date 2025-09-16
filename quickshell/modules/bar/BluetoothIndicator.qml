import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.widgets

Item {
  id: root
  implicitWidth: content.implicitWidth + content.spacing * 2
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: 4
    MaterialSymbol {
      id: symbol
      Layout.leftMargin: -6
      Layout.rightMargin: -6
      text: `${BluetoothHandler.symbolName}`
    }
  }
}

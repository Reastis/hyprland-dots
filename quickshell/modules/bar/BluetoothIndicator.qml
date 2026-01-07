import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.widgets

Item {
  id: root
  implicitWidth: content.implicitWidth
  RowLayout {
    id: content
    anchors.centerIn: parent
    MaterialSymbol {
      id: symbol
      Layout.leftMargin: 0
      Layout.rightMargin: 0
      text: `${BluetoothHandler.symbolName}`
    }
  }
}

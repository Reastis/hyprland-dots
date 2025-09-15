import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.widgets

Item {
  id:root
  implicitWidth: content.implicitWidth
  RowLayout {
    id: content
    anchors.centerIn: parent
    MaterialSymbol {
      id: symbol
      Layout.leftMargin: -2
      Layout.rightMargin: -2
      text: `${BluetoothHandler.symbolName}`
    }
  }
}

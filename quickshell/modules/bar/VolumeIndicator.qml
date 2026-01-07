import QtQuick
import QtQuick.Layouts
import qs.modules.widgets
import qs.services
import Quickshell

Item {
  id: root
  implicitWidth: content.implicitWidth
  RowLayout {
    id: content
    anchors.centerIn: parent
    MaterialSymbol {
      id: symbol
      fill: 1
      Layout.leftMargin: 0
      Layout.rightMargin: 0
      text: `${Audio.soundSymbolName}`
    }
  }
}

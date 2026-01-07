import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.services
import qs.modules.widgets

Item {
  id: root
  implicitWidth: content.implicitWidth
  property string networkName: Network.networkStrength
  RowLayout {
    id: content
    anchors.centerIn: parent
    MaterialSymbol {
      Layout.leftMargin: 0
      Layout.rightMargin: 0
      text: `${Network.symbolName}`
    } 
  }
}

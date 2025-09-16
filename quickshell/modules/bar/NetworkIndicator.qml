import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.services
import qs.modules.widgets

Item {
  id: root
  implicitWidth:content.implicitWidth + content.spacing * 2
  property string networkName: Network.networkStrength
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: 4
    MaterialSymbol {
      Layout.leftMargin: -2
      Layout.rightMargin: -2
      text:`${Network.symbolName}`
    } 
  }
}

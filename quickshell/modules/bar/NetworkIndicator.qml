import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.services
import qs.modules.widgets

Item {
  id: networkIndicatorRoot
  implicitWidth:rowLayout.implicitWidth + rowLayout.spacing * 2
  property string networkName: Network.networkStrength
  RowLayout {
    id: rowLayout
    anchors.centerIn: parent
    MaterialSymbol {
      Layout.leftMargin: -2
      Layout.rightMargin: -2
      text:`${Network.symbolName}`
    } 
  }
}

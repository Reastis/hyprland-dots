import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.widgets
import Quickshell.Widgets
import Quickshell
Item {
  id: batteryIndicatorRoot
  implicitWidth: rowLayout.implicitWidth + rowLayout.spacing * 2
  property real percentage: Battery.percentage
  RowLayout {
    id: rowLayout
    anchors.centerIn: parent
    spacing: 2
    StyledText {
      verticalAlignment: Text.AlignVCenter
      text: `${Math.round(percentage*100)}%`
    }
    MaterialSymbol {
      fill: 1
      Layout.leftMargin: -4
      text: `${Battery.symbolName}`
    }
  }
}

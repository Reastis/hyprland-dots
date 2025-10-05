import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.widgets
import Quickshell.Widgets
import Quickshell
Item {
  id: root
  implicitWidth: content.implicitWidth + content.spacing * 2
  property real percentage: Battery.percentage
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: 4
    StyledText {
      verticalAlignment: Text.AlignVCenter
      text: `${Math.round(percentage*100)}%`
    }
    MaterialSymbol {
      fill: 1
      Layout.leftMargin: -6
      Layout.rightMargin: -4
      text: `${Battery.symbolName}`
    }
  }
}

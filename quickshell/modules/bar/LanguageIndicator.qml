import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.widgets

Item {
  id: root
  implicitWidth: content.implicitWidth
  property string kbLayout: SystemInfo.kbLayout
  RowLayout{
    id: content
    anchors.centerIn:parent
    StyledText {
      Layout.preferredWidth: 30
      Layout.alignment:Layout.AlignVCenter
      text: kbLayout
      isBold: true
    }
  }
}

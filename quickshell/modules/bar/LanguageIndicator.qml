import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.widgets

StyledText {
  property string kbLayout: SystemInfo.kbLayout
  Layout.alignment: Qt.AlignCenter
  horizontalAlignment: Text.AlignHCenter
  text: kbLayout
  isBold: true
}

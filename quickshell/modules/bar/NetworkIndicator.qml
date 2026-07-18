import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.services
import qs.modules.widgets

StyledIcon {
  property string networkName: Network.networkStrength
  Layout.alignment: Qt.AlignCenter
  iconName: `${Network.symbolName}`
}

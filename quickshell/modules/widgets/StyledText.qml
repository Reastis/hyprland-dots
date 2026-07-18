import QtQuick
import qs.common

Text {

  property color fontColor: Appearance.colorScheme.cOnSurface
  property string fontFamily: "Noto Sans Mono" //"Roboto Mono"
  property real fontPointSize: Appearance.fonts.fontSizeM
  property bool isBold: false

  renderType: Text.QtRendering
  verticalAlignment: Text.AlignTop
  horizontalAlignment: Text.AlignLeft
  color: fontColor
  font {
    family: fontFamily
    bold: isBold
    pointSize: fontPointSize
  }
}

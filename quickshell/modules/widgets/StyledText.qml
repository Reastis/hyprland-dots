import QtQuick

Text {
  renderType: Text.NativeRendering
  height:15
  verticalAlignment: Text.AlignTop
  horizontalAlignment: Text.AlignLeft

  property string fontFamily: "Roboto Mono"
  property real fontPixelSize: 16
  property bool isBold: false
  font {
    family: fontFamily
    bold: isBold
    pixelSize:fontPixelSize
  }
  color: "white"
}

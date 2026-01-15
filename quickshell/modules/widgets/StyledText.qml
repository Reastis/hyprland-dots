import QtQuick

Text {
  renderType: Text.NativeRendering
  height:15
  verticalAlignment: Text.AlignTop
  horizontalAlignment: Text.AlignLeft

  property bool isBold: false
  font {
    family: "Roboto"
    bold: isBold
    pixelSize:16
  }
  color: "white"
}

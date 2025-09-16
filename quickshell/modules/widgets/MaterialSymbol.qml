import QtQuick

StyledText {
  verticalAlignment: Text.AlignVCenter
  property int symbolSize: 24 
  property real fill: 0
  font {
    family: "Material Symbols Rounded"
    bold:false
    pixelSize: symbolSize
    variableAxes: {
      "FILL": fill,
      "opsz": symbolSize
    }
  }
}

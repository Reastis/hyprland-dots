import QtQuick

StyledText {
  verticalAlignment: Text.AlignVCenter
  property int symbolSize: 24 
  font {
    family: "Material Symbols Rounded"
    property real fill: 0
    pixelSize: symbolSize
    variableAxes: {
      "FILL": fill,
      "opsz": symbolSize
    }
  }
}

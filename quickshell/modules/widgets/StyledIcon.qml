import QtQuick
import qs.services
import qs.common

StyledText {
  property string iconName
  text: IconMap.getIcon(iconName)
  verticalAlignment: Text.AlignVCenter
  property int symbolSize: 18
  property real fill: 0
  font {
    family: Appearance.fonts.iconsFontFamily // "Material Symbols Rounded"
    bold: false
    pointSize: symbolSize
    // variableAxes: {
    //   "FILL": fill,
    //   "opsz": symbolSize
    // }
  }
}

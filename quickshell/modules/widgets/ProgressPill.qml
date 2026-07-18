import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import qs.common


Item {
  id: root

  required property real progressValue

  property bool isHorizontal: true
  property bool showValue: true

  property color progressColor: Appearance.colorScheme.cPrimary
  property color baseColor: Appearance.colorScheme.cPrimaryContainer
  property color valueFilledColor: Appearance.colorScheme.cOnPrimary
  property color valueBaseColor: Appearance.colorScheme.cOnPrimaryContainer

  property real cornerRadius: 6
  property real pillSize: 6
  property real pillHeight: isHorizontal? 20 : 35
  property real pillWidth: isHorizontal? 35 : 30
  implicitHeight: pillHeight
  implicitWidth: pillWidth

  ClippingRectangle {
    id: background
    implicitWidth: pillWidth
    implicitHeight: pillHeight
    color: root.baseColor
    radius: root.cornerRadius

    StyledText {
      id: valueBase
      visible: showValue
      anchors.centerIn: parent
      fontPointSize: Appearance.fonts.fontSizeS
      color: valueBaseColor
      text: `${progressValue}%`
    }

    ClippingRectangle {
      id: progress
      x: 0
      y: isHorizontal? 0 : root.pillHeight - height
      width: isHorizontal? root.pillWidth * (root.progressValue/100) : root.pillWidth
      height: isHorizontal? root.pillHeight : root.pillHeight * (root.progressValue/100)
      layer.enabled: true
      color: root.progressColor

      StyledText {
        id: valueFilled
        visible: root.showValue
        fontPointSize: Appearance.fonts.fontSizeS
        color: valueFilledColor
        text: `${root.progressValue}%`

        x: background.width/2 - this.width/2
        y: background.height/2 - this.height/2 - (background.height - progress.height)
      }
    }
  }
}

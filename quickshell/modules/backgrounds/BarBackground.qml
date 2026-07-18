import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import qs.services
import qs.common

ShapePath {
  id: root

  required property ShellScreen mainWindow
  required property var bar
  readonly property var configSettings: Settings.config.barSettings

  property string mode: configSettings.mode
  property string anchor: configSettings.anchor
  readonly property point barPos: {
    switch (anchor) {
      case "top":
        return Qt.point(0 + bar?.margins.left, 0 + bar?.margins.top)
      case "bottom":
        return Qt.point(0 + bar?.margins.left, mainWindow.height - bar?.margins.bottom - bar?.implicitHeight)
      case "left":
        return Qt.point(0 + bar?.margins.left, 0 + bar?.margins.top)
      case "right":
        return Qt.point(mainWindow.width - bar?.margins.right - bar?.implicitWidth, 0 + bar?.margins.top)
    }
  }
  readonly property real barHeight: bar?.implicitHeight + bar?.margins.top + bar?.margins.bottom
  readonly property real barWidth: bar?.implicitWidth + bar?.margins.left + bar?.margins.right
  readonly property real screenHeight: mainWindow?.height
  readonly property real screenWidth: mainWindow?.width

  property real borderThickness: mode === "docked"? 0 : configSettings.borderThickness
  property real minRounding: 0.001
  property real outerFrameRadius: mode === "floating"? configSettings.outerFrameRadius : minRounding
  property real innerFrameRadius: mode === "framed" || mode === "docked"? configSettings.innerFrameRadius : minRounding

  property var pivots: {
    switch (mode) {
      case "floating":
        return {
          tl: Qt.point(barPos.x, barPos.y),
          tr: Qt.point(barPos.x + bar?.width, barPos.y),
          bl: Qt.point(barPos.x, barPos.y + bar?.height),
          br: Qt.point(barPos.x + bar?.width, barPos.y + bar?.height),
        }
      case "framed":
        return {
          tl: Qt.point(0, 0),
          tr: Qt.point(screenWidth, 0),
          bl: Qt.point(0, screenHeight),
          br: Qt.point(screenWidth, screenHeight),
        }
      case "docked":
        return {
          tl: Qt.point(0, 0),
          tr: Qt.point(screenWidth, 0),
          bl: Qt.point(0, screenHeight),
          br: Qt.point(screenWidth, screenHeight),
        }
      case "solid":
        return {
          tl: Qt.point(barPos.x - bar?.margins.left, barPos.y - bar?.margins.top),
          tr: Qt.point(barPos.x + barWidth - bar?.margins.left, barPos.y - bar?.margins.top),
          bl: Qt.point(barPos.x - bar?.margins.left, barPos.y + barHeight - bar?.margins.top),
          br: Qt.point(barPos.x + barWidth - bar?.margins.left, barPos.y + barHeight - bar?.margins.top),
        }
    }
  }

  property point pivotTL: pivots.tl
  property point pivotTR: pivots.tr
  property point pivotBL: pivots.bl
  property point pivotBR: pivots.br

  property var frame: {
    switch (mode) {
      case "framed":
        return {
          x: anchor === "left"? barWidth : borderThickness,
          y: anchor === "top"? barHeight : borderThickness,
          width: anchor === "left" || anchor === "right"? screenWidth -  (barWidth + borderThickness) : screenWidth - 2 * borderThickness,
          height: anchor === "top" || anchor === "bottom"? screenHeight - (barHeight + borderThickness) : screenHeight - 2 * borderThickness
        }
      case "docked":
        return {
          x: anchor === "left"? barWidth : borderThickness,
          y: anchor === "top"? barHeight : borderThickness,
          width: anchor === "right"? screenWidth - (barWidth + 2 * borderThickness) : screenWidth - 2 * borderThickness,
          height: anchor === "bottom"? screenHeight - (barHeight + 2 * borderThickness) : screenHeight - 2 * borderThickness
        }
      default:
        return {
          x: pivotTL.x + 1,
          y: pivotTL.y + minRounding,
          width: 0.1,
          height: 0.1
        }
    }
  }

  property real frameX: frame.x
  property real frameY: frame.y
  property real frameWidth: frame.width
  property real frameHeight: frame.height

  startX: pivotTL.x + outerFrameRadius
  startY: pivotTL.y
  fillColor: mode === "empty"? "transparent" : Appearance.colorScheme.cSurface // "#34252F"
  strokeColor: "transparent"
  strokeWidth: -1
  fillRule: mode === "framed" || mode === "docked"? ShapePath.OddEvenFill : ShapePath.WindingFill
  // Top border
  PathLine {
    x: pivotTR.x - outerFrameRadius
    y: pivotTR.y
  }
  // Top right corner
  PathArc {
    x: pivotTR.x
    y: pivotTR.y + outerFrameRadius
    radiusX: outerFrameRadius
    radiusY: outerFrameRadius
    direction: PathArc.Clockwise
  }
  // Right border
  PathLine {
    x: pivotBR.x
    y: pivotBR.y - outerFrameRadius
  }
  // Bottom right corner
  PathArc {
    x: pivotBR.x - outerFrameRadius
    y: pivotBR.y
    radiusX: outerFrameRadius
    radiusY: outerFrameRadius
    direction: PathArc.Clockwise
  }
  // Bottom border
  PathLine {
    x: pivotBL.x + outerFrameRadius
    y: pivotBL.y
  }
  // Bottom left corner
  PathArc {
    x: pivotBL.x
    y: pivotBL.y - outerFrameRadius
    radiusX: outerFrameRadius
    radiusY: outerFrameRadius
    direction: PathArc.Clockwise
  }
  // Left border
  PathLine {
    x: pivotTL.x
    y: pivotTL.y + outerFrameRadius
  }
  // Top left corner
  PathArc {
    x: pivotTL.x + outerFrameRadius
    y: pivotTL.y
    radiusX: outerFrameRadius
    radiusY: outerFrameRadius
    direction: PathArc.Clockwise
  }

  PathMove {
    x: frameX + innerFrameRadius
    y: frameY
  }

  // Top border
  PathLine {
    x: frameX + frameWidth - innerFrameRadius
    y: frameY
  }
  //Top left corner
  PathArc {
    x: frameX + frameWidth
    y: frameY + innerFrameRadius
    radiusX: innerFrameRadius
    radiusY: innerFrameRadius
    direction: PathArc.Clockwise
  }
  //Right border
  PathLine {
    x: frameX + frameWidth
    y: frameY + frameHeight - innerFrameRadius
  }
  // Bottom right corner
  PathArc {
    x: frameX + frameWidth - innerFrameRadius
    y: frameY + frameHeight
    radiusX: innerFrameRadius
    radiusY: innerFrameRadius
    direction: PathArc.Clockwise
  }
  //Bottom border
  PathLine {
    x: frameX + innerFrameRadius
    y: frameY + frameHeight
  }
  // Bottom left corner
  PathArc {
    x: frameX
    y: frameY + frameHeight - innerFrameRadius
    radiusX: innerFrameRadius
    radiusY: innerFrameRadius
    direction: PathArc.Clockwise
  }
  //Left border
  PathLine {
    x: frameX
    y: frameY + innerFrameRadius
  }
  // Top left corner
  PathArc {
    x: frameX + innerFrameRadius
    y: frameY
    radiusX: innerFrameRadius
    radiusY: innerFrameRadius
    direction: PathArc.Clockwise
  }
}

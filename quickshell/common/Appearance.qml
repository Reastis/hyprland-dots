pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  property QtObject fonts: QtObject {
    id: fonts
    property FontLoader defaultIconsFont: FontLoader {
      id: defaultIconsFont
      source: Quickshell.shellDir + "/assets/fonts/tabler-icons.ttf"
    }
    readonly property string iconsFontFamily: defaultIconsFont.status == FontLoader.Ready? defaultIconsFont.name : ""
    readonly property real fontSizeXS: 8
    readonly property real fontSizeS: 10
    readonly property real fontSizeM: 12
    readonly property real fontSizeL: 14
    readonly property real fontSizeXL: 16
  }

  property QtObject animations: QtObject {
    id: animations
    readonly property int delaySwiftest: 50
    readonly property int delaySwifter: 100
    readonly property int delaySwift: 200
    readonly property int delayNormal: 300
    readonly property int delaySlow: 400
    readonly property int delaySlower: 800
    readonly property int delaySlowest: 1000
  }

  property QtObject colorScheme: QtObject {
    id: colorScheme
    property color cPrimary: "#ffb598"
    property color cOnPrimary: "#552008"
    property color cPrimaryContainer: "#71361c"
    property color cOnPrimaryContainer: "#ffdbce"
    property color cSecondary: "#e7beae"
    property color cOnSecondary: "#442a20"
    property color cSecondaryContainer: "#5d4035"
    property color cOnSecondaryContainer: "#ffdbce"
    property color cTertiary:"#d4c78e"
    property color cOnTertiary: "#383006"
    property color cTertiaryContainer: "#4f471b"
    property color cOnTertiaryContainer: "#f0e3a8"
    property color cError: "#ffb4ab"
    property color cOnError: "#690005"
    property color cErrorContainer: "#93000a"
    property color cOnErrorContainer: "#ffdad6"
    property color cSurface: "#1a110e"
    property color cOnSurface: "#f1dfd9"
    property color cSurfaceDim: "#e8d6d1"
    property color cSurfaceBright: "#fff8f6"
    property color cSurfaceContainer:"#271e1a"
  }

  property QtObject margins: QtObject {
    id: margins
    property int marginXS: 3
    property int marginS: 6
    property int marginM: 9
    property int marginL: 12
    property int marginXL: 15
  }

  property QtObject rounding: QtObject {
    id: rounding
    property int roundingXS: 6
    property int roundingS: 8
    property int roundingM: 10
    property int roundingL: 12
    property int roundingXL: 14
  }

  property QtObject barStyle: QtObject {
    id: barStyle
    readonly property real contentSpacing: 8
    readonly property real contentPadding: 10
    readonly property real contentMargin: 3
  }
}

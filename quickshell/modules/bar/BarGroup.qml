import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.common

Item {
  id: root

  property bool isHorizontal: parent.isHorizontal === false? false : true

  property real contentPadding: Appearance.barStyle.contentPadding
  property real contentMargin: Appearance.barStyle.contentMargin
  implicitHeight: isHorizontal? parent.height : content.implicitHeight + contentPadding * 2
  implicitWidth: isHorizontal? content?.implicitWidth + contentPadding * 2 : parent.width
  default property alias items: content.children
  opacity: items.some((item) => item.opacity > 0)? 1 : 0
  Rectangle {
    id: background
    anchors {
      fill: parent
      margins: contentMargin
      centerIn: parent
    }
    color: Appearance.colorScheme.cSurfaceContainer
    radius: Appearance.rounding.roundingM
  }
  GridLayout {
    id: content
    anchors {
      centerIn: parent
    }
    Layout.alignment: Qt.AlignCenter
    rows: isHorizontal ? 1 : -1
    columns: isHorizontal ? -1 : 1
    rowSpacing: Appearance.barStyle.contentSpacing
    columnSpacing: Appearance.barStyle.contentSpacing
  }
}

import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
  id: root
  property real contentPadding: 6
  property real contentMargin: 3
  implicitHeight: parent.implicitHeight
  implicitWidth: content.implicitWidth + contentPadding * 2
  default property alias items: content.children
  Rectangle {
    id: background
    anchors {
      fill: parent
      margins: contentMargin
    }
    color: "#CF0F47"
    radius: 10
  }
  RowLayout {
    id: content
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    spacing: 10
  }
}

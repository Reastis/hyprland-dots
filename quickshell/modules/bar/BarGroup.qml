import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
  id: barGroupRoot
  property real contentPadding: 3
  implicitHeight: parent.implicitHeight
  implicitWidth: rowLayout.implicitWidth + contentPadding * 2
  default property alias items: rowLayout.children
  Rectangle {
    id: background
    anchors {
      fill: parent
      topMargin:contentPadding
      bottomMargin:contentPadding
      rightMargin:contentPadding
      leftMargin:contentPadding
    }
    color:"red"
    radius: 10
  }
  RowLayout {
    id: rowLayout
    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      right: parent.right
      leftMargin: parent.contentPadding
      rightMargin: parent.contentPadding
    }
    spacing: 4

  } 
}

import qs.services
import qs.modules.widgets
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  implicitWidth: content.implicitWidth + content.spacing * 2
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: 4
    StyledText{
      text: DateTime.time
    }
  }
}

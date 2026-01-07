import qs.services
import qs.modules.widgets
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  implicitWidth: content.implicitWidth
  RowLayout {
    id: content
    anchors.centerIn: parent
    StyledText {
      text: DateTime.time
    }
  }
}

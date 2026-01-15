import QtQuick


ListView {
  id: root
  spacing: 4
  add: Transition {
    ParallelAnimation {
      NumberAnimation {
        property: "opacity"
        from:0
        to:1
        duration:300
      }
    }
  }
}

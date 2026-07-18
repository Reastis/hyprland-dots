import qs.modules
import qs.modules.bar
import qs.modules.notifications
import qs.services
import QtQuick
import Quickshell

ShellRoot {
  property bool settingsLoaded: false

  Connections {
    target: Settings ? Settings : null
    function onLoaded() {
      settingsLoaded = true
    }
  }

  Loader {
    active: settingsLoaded
    sourceComponent: Item {
      ScreenCanvas {}
      LazyLoader {active: true; component: NotificationPanel {}}
    }
  }
}

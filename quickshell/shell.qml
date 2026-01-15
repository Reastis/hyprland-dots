import qs.modules.bar
import qs.modules.notifications
import QtQuick
import Quickshell

ShellRoot {
  LazyLoader {active: true; component: Bar {}}
  LazyLoader {active: true; component: NotificationPanel {}}
}

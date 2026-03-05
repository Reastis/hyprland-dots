pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Singleton {
  id: root

  property list<var> trayItems: SystemTray.items.values
}

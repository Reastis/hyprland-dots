import "./modules/bar/"
import QtQuick
import Quickshell

ShellRoot {
  LazyLoader {active: true; component: Bar {}}
}

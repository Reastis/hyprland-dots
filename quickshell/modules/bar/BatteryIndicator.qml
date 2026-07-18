import QtQuick
import QtQuick.Layouts
import qs.services
import qs.common
import qs.modules.widgets

ProgressPill {
  id: root
  property real charge: Math.round(Battery.percentage*100)
  property real isCharging: Battery.isCharging
  showValue: true
  progressValue: charge
  baseColor: isCharging? Appearance.colorScheme.cPrimaryContainer : charge <= 20? Appearance.colorScheme.cErrorContainer : Appearance.colorScheme.cSecondaryContainer
  progressColor: isCharging? Appearance.colorScheme.cPrimary : charge <= 20? Appearance.colorScheme.cError : Appearance.colorScheme.cSecondary
  valueFilledColor: isCharging? Appearance.colorScheme.cOnPrimary : Appearance.colorScheme.cOnSecondary
  valueBaseColor: isCharging? Appearance.colorScheme.cOnPrimaryContainer : charge <= 20? Appearance.colorScheme.cOnErrorContainer : Appearance.colorScheme.cOnSecondaryContainer
}

pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root


  component Notif: QtObject {
    id: notif
    required property int notifId
    property Notification notification
    property double time
    property bool popup: false
    property bool isTimedOut: false
    property int expireTimeout: notification?.expireTimeout ?? -1
    property var binds: new Set()
    onNotificationChanged: {
      if (notification == undefined) {
        this.popup = false;
        isTimedOut = true;
        expire();
      }
    }
    property Timer timer: Timer {
      id: timer
      interval: expireTimeout > 0? expireTimeout*1000 : 5000
      running: true
      onTriggered: () => {
        popup = false;
        isTimedOut = true;
        expire();
      }
    }
    property string urgency //: notification?.urgency.toString() ?? "normal"
    property string appName //: notification?.appName ?? ""
    property string summary //: notification?.summary ?? ""
    property string appIcon //: notification?.appIcon ?? ""
    property string image //: notification?.image ?? ""
    property string body //: notification?.body ?? ""
    property bool isTransient //: notification?.transient ?? false
    
    Component.onCompleted: {
      appName = notification?.appName ?? "";
      summary = notification?.summary ?? "";
      appIcon = notification?.appIcon ?? "";
      image = notification?.image ?? "";
      body = notification?.body ?? "";
      isTransient = notification?.transient ?? false;
    }
    function expire() {
      if (binds.size === 0 & root.notifications.includes(this)) {
        root.notifications = root.notifications.filter((notif) => notif.notifId != this.notifId);
        notification?.expire();
        this.destroy();
      }
    }
    function bind(element) {
      binds.add(element);
    }
    function unbind(element) {
      binds.delete(element);
      if (isTimedOut) {
        expire();
      }
    }
  }

  component NotifGroup: QtObject {
    id: notifGroup
    property list<var> notifs: []
    property string appName
    property string appIcon
    property string summary
    property int expireTimeout
    property bool popup: false
    property var binds: new Set()
    property bool isTimedOut: false
    property Timer timer: Timer {
      id: timer
      interval: expireTimeout > 0? expireTimeout*1000 : 5000
      running: true
      onTriggered: () => {
        popup = false;
        isTimedOut = true;
        expire();
      }
    }
    function expire() {
      if (binds.size === 0 & root.notificationGroups.includes(this)) {
        root.notificationGroups = root.notificationGroups.filter((notifGroup) => notifGroup !== this && !notifGroup.isTimedOut);
        notifs.forEach((notif) => notif.unbind(this));
        this.destroy();
      }
    }
    function resetTimer(newExpireTimeout) {
      expireTimeout = newExpireTimeout;
      timer.restart()
    }
    function bind(element) {
      binds.add(element);
    }
    function unbind(element) {
      binds.delete(element);
      if (isTimedOut) {
        expire();
      }
    }
  }
  Component {
    id: notifConstructor
    Notif{}
  }
  Component {
    id: notifGroupConstructor
    NotifGroup{}
  }

  function notifGroupsToList(groupedNotifs) {
    const notifGroupList = Object.keys(groupedNotifs).map((key) => {
      return groupedNotifs[key]
    });
    return notifGroupList;
  }

  property list<var> notifications
  property list<var> notificationGroups: []
  property list<var> popupNotifications: notifications.filter((notification) => notification.popup)
  property list<var> popupNotificationGroups: notificationGroups.filter((notificationGroup) => notificationGroup.popup)

  NotificationServer {
    id:notifServer

    keepOnReload: false
    persistenceSupported: true
    imageSupported: true
    bodySupported: true

    onNotification: (notification) => {
      notification.tracked = true
      var newNotification = notifConstructor.createObject(root, {
        "notifId": notification.id,
        "notification": notification,
        "time": Date.now(),
      })
      newNotification.popup = true;
      root.notifications = [...root.notifications, newNotification];
      if (!notificationGroups.some((notifGroup) => notifGroup.appName === newNotification.appName && notifGroup.summary === newNotification.summary && !notifGroup.isTimedOut)){
        notificationGroups.push(notifGroupConstructor.createObject(root, {
          appName: newNotification.appName,
          appIcon: newNotification.appIcon,
          summary: newNotification.summary
        }));
      }
      const index = notificationGroups.findIndex(notifGroup => newNotification.appName && notifGroup.summary === newNotification.summary && !notifGroup.isTimedOut)
      newNotification.bind(notificationGroups[index]);
      notificationGroups[index].notifs.push(newNotification);
      notificationGroups[index].popup = true;
      notificationGroups[index].resetTimer(newNotification.expireTimeout);
    }
  }
}


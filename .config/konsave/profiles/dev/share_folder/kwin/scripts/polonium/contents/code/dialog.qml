// SPDX-FileCopyrightText: 2018-2019 Eon S. Jeon <esjeon@hyunmu.am>
// SPDX-FileCopyrightText: 2021 Mikhail Zolotukhin <mail@gikari.com>
// SPDX-FileCopyrightText: 2023 Vaughan Milliman <vaughanm1@protonmail.com>
// SPDX-License-Identifier: MIT

// (mostly) copied from bismuth

import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.kwin 2.0
import org.kde.plasma.components 3.0 as PC3
import org.kde.plasma.core 2.0 as PlasmaCore

PlasmaCore.Dialog {
    id: popupDialog

    property rect screenGeometry

    function show(text) {
        // Abort any previous timers
        hideTimer.stop();
        // Update current screen information
        this.screenGeometry = workspace.clientArea(KWin.FullScreenArea, workspace.activeScreen, workspace.currentDesktop);
        // Set the text
        messageText.text = text;
        // Show the popup
        this.visible = true;
        // Start popup hide timer
        hideTimer.interval = 1000;
        hideTimer.start();
    }

    type: PlasmaCore.Dialog.OnScreenDisplay
    flags: Qt.Popup | Qt.WindowStaysOnTopHint
    location: PlasmaCore.Types.Floating
    outputOnly: true
    // Spawn popup a little bit lower than the center of the screen for consistency
    x: (screenGeometry.x + screenGeometry.width / 2) - width / 2
    y: (screenGeometry.y + screenGeometry.height * 2 / 3) - height / 2
    visible: false
    Component.onCompleted: {
        KWin.registerWindow(this);
    }

    mainItem: RowLayout {
        id: main

        // Make popup size consistent with the other Plasma OSD (e.g. PulseAudio one)
        Layout.minimumWidth: Math.max(messageText.implicitWidth, PlasmaCore.Units.gridUnit * 10)
        Layout.minimumHeight: PlasmaCore.Units.gridUnit * 1.35

        PC3.Label {
            id: messageText

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            // This font size matches the one from Pulse Audio OSD for consistency
            font.pointSize: PlasmaCore.Theme.defaultFont.pointSize * 1.2
            horizontalAlignment: Text.AlignHCenter
        }

        // Hides the popup window when triggered
        Timer {
            id: hideTimer

            repeat: false
            onTriggered: {
                popupDialog.visible = false;
            }
        }

    }

}

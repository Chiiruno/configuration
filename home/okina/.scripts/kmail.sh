#!/bin/sh
kmail&
sleep 2
qdbus org.kde.kmail2 /kmail2/kmail_mainwindow_1 org.qtproject.Qt.QWidget.hide

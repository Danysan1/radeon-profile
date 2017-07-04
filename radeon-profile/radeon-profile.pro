#-------------------------------------------------
#
# Project created by QtCreator 2013-03-01T15:55:52
#
#-------------------------------------------------

QT       += core gui network widgets charts printsupport

TARGET = radeon-profile
TEMPLATE = app

QMAKE_CXXFLAGS += -std=c++0x

#   https://forum.qt.io/topic/10178/solved-qdebug-and-debug-release/2
#   http://doc.qt.io/qt-5/qtglobal.html#QtMsgType-enum
#   qDebug will work only when compiled for Debug
#   QtWarning, QtCritical and QtFatal will still work on Release
CONFIG(release, debug|release){
    message('Building for release')
    DEFINES += QT_NO_DEBUG_OUTPUT
} else {
    message('Building for debug')
    QMAKE_CXXFLAGS += -Wall -Wextra -Wpedantic
}

SOURCES += main.cpp\
        radeon_profile.cpp \
    uiElements.cpp \
    uiEvents.cpp \
    gpu.cpp \
    dxorg.cpp \
    settings.cpp \
    daemonComm.cpp \
    ioctlHandler.cpp \
    ioctl_radeon.cpp \
    ioctl_amdgpu.cpp \
    execTab.cpp \
    execbin.cpp \
    dialog_rpevent.cpp \
    eventsTab.cpp \
    fanControlTab.cpp \
    dialog_defineplot.cpp \
    plotsTab.cpp \
    dialog_topbarcfg.cpp

HEADERS  += radeon_profile.h \
    gpu.h \
    dxorg.h \
    globalStuff.h \
    daemonComm.h \
    execbin.h \
    dialog_rpevent.h \
    rpevent.h \
    ioctlHandler.h \
    components/rpplot.h \
    dialog_defineplot.h \
    components/pieprogressbar.h \
    components/topbarcomponents.h \
    dialog_topbarcfg.h

FORMS    += radeon_profile.ui \
    dialog_rpevent.ui \
    dialog_defineplot.ui \
    components/pieprogressbar.ui \
    dialog_topbarcfg.ui

RESOURCES += \
    radeon-resource.qrc

# NOTE FOR PACKAGING
# /usr/include/X11/extensions/Xrandr.h must be present at compile time
# /usr/lib/libXrandr.so must be present at runtime
# These are provided in libxrandr(Arch), libXrandr(RedHat,Fedora), libxrandr-dev(Debian,Ubuntu), libxrandr-devel(SUSE)
LIBS += -lXrandr -lX11

# NOTE FOR PACKAGING
# In this folder are present translation files (strings.*.ts)
# After editing a translatable string it is necessary to run "lupdate" in this folder (QtCreator: Tools > External > Linguist > Update)
# Then these files can be edited with the Qt linguist
# When the translations are ready it is necessary to run "lrelease" in this folder (QtCreator: Tools > External > Linguist > Release)
# This produces compiled translation files (strings.*.qm), that need to be packaged together with the runnable
# These can be placed in "/usr/share/radeon-profile/" or in the same folder of the binary (useful for development)
TRANSLATIONS += translations/strings.it.ts \
    translations/strings.pl.ts \
    translations/strings.hr.ts

DISTFILES += \
    $$TRANSLATIONS

OTHER_FILES += \
    configure \
    Doxyfile

# AUTOMATIC MAKEFILE INSTRUCTIONS FOR make clean
# http://doc.qt.io/qt-5/qmake-variable-reference.html#qmake-clean
QMFILES = $$replace(TRANSLATIONS,".ts",".qm")
QMAKE_CLEAN += $$QMFILES


# AUTOMATIC MAKEFILE INSTRUCTIONS FOR make install
# http://doc.qt.io/qt-5/qmake-advanced-usage.html#installing-files
# binary: /usr/bin/radeon-profile
binary.path = /$(DESTDIR)/$$PREFIX/bin/
binary.files = radeon-profile
# https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html#install_icons
# icon: /usr/share/icons/hicolor/512x512/apps/radeon-profile.png
icon.path = /$(DESTDIR)/$$PREFIX/share/icons/hicolor/512x512/apps/
icon.files = extra/radeon-profile.png
# desktop: /usr/share/applications/radeon-profile.desktop
desktop.path = /$(DESTDIR)/$$PREFIX/share/applications/
desktop.files = extra/radeon-profile.desktop
# appdata: /usr/share/appdata/radeon-profile.appdata.xml
appdata.path = /$(DESTDIR)/$$PREFIX/share/appdata/
appdata.files = extra/radeon-profile.appdata.xml
# translate: /usr/share/radeon-profile/strings.*.qm
# https://wiki.qt.io/Undocumented_QMake#Custom_install_config
# https://wiki.qt.io/Automating_generation_of_qm_files
translate.path = /$(DESTDIR)/$$PREFIX/share/radeon-profile/
translate.files = $$QMFILES
qtPrepareTool(LRELEASE, lrelease)
translate.extra = $$LRELEASE $$_PRO_FILE_
translate.CONFIG += no_check_exist # By default qmake install targets work only with files that exist before the execution of qmake; translations are generated after, this flag tells qmake to install them anyway
INSTALLS += binary icon desktop appdata translate

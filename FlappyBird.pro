# V-Play project
CONFIG += v-play_daily

# V-Play Demo Game
customFolder.source = qml
DEPLOYMENTFOLDERS += customFolder

# Add sources
SOURCES += main.cpp

# If you want to deploy to Symbian or Meego please have a look at the demo games' project files 
# on how to set up the capabilities for Symbian and the desktop icon for Meego

# Add Icon
win32 {
    # Icon Resource for exe file
    RC_FILE += win/app_icon.rc
    # Icon Resource for dynamic icon of title bar and task bar
    # If using MSVC the code may end up in "release" or "debug" sub dir
    CONFIG(debug, debug|release): OUTDIR = debug
    else: OUTDIR = release
    # copy the icon file to the exe folder
    QMAKE_POST_LINK += copy /y \"$$PWD\"\\win\\app_icon.ico \"$$OUT_PWD\"\\\"$$OUTDIRs\"
}

# Following configs are needed for Mac App Store publishing
macx {
    COMPANY = "V-Play GmbH"
    BUNDLEID = net.vplay.demos.mac.flappybird
    ICON = macx/app_icon.icns
    QMAKE_INFO_PLIST = macx/game.plist
    ENTITLEMENTS = macx/game.entitlements
}

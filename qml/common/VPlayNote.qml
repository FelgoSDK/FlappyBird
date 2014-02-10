import QtQuick 1.1
import VPlay 1.0

Item {
  //anchors.horizontalCenter: parent.horizontalCenter
  anchors.bottom: parent.bottom
  width: parent.width

  SingleSpriteFromFile {
    id: logo
    filename: "../img/images-sd.json"
    source: "vplay-logo.png"
    scale: 0.5
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: -35

    MouseArea {
      anchors.fill: parent
      onClicked: {
        messageBoxInputState = "visitVPlayWebsite"
        nativeUtils.displayMessageBox(qsTr("V-Play Game Engine"), qsTr("This version of Flappy Bird is built with V-Play Game Engine. The source code is available in the free V-Play SDK - so you can build your own Flappy Bird in minutes!\n\nVisit V-Play.net now? \n(It contains a tutorial how to make Flappy Bird and more details)"), 2)
      }
    }

    // this could be used to fade in & out the logo; but it's distracting, so do not fade
//    SequentialAnimation {
//      running: true
//      loops: -1
//      NumberAnimation { target: logo; property: "opacity"; to: 0.1; duration: 1200 }
//      NumberAnimation { target: logo; property: "opacity"; to: 1; duration: 1200 }
//    }

  }


}

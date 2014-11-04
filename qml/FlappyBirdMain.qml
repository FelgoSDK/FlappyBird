import VPlay 2.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
  id: window
  width: 640
  height: 960

  // you get free licenseKeys as a V-Play customer or in your V-Play Trial
  // with a licenseKey, you get the best development experience:
  //  * No watermark shown
  //  * No license reminder every couple of minutes
  //  * No fading V-Play logo
  // you can generate one from http://v-play.net/license/trial, then enter it below:
  //licenseKey: "<generate one from http://v-play.net/license/trial>"

  property alias window: window
  activeScene: splash

  // show the splash and start the loading process as soon as the GameWindow is ready
  Component.onCompleted: {
    splash.opacity = 1
    mainItemDelay.start()
  }

  // since the splash has a fade in animation, we delay the loading of the game until the splash is fully displayed for sure
  Timer {
    id: mainItemDelay
    interval: 500
    onTriggered: {
      mainItemLoader.source = "MainItem.qml"
    }
  }

  // as soon as we set the source property, the loader will load the game
  Loader {
    id: mainItemLoader
    onLoaded: {
      if(item) {
        hideSplashDelay.start()
      }
    }
  }

  // give the game a little time to fully display before hiding the splash, just to be sure it looks smooth also on low-end devices
  Timer {
    id: hideSplashDelay
    interval: 200
    onTriggered: {
      splash.opacity = 0
    }
  }

  SplashScene {
    id: splash
  }
}

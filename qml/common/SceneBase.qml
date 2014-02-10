import QtQuick 1.1
import VPlay 1.0

// base component for all scenes in the game
Scene {
  id: sceneBase
  // this is important, as it serves as the reference size for the mass of the phyiscs objects, because the mass of a body depends on the width of its images
  width: 320
  height: 480

  opacity: 0

  // handle this signal in each Scene
  signal backPressed
  signal enterPressed

  Keys.onPressed: {
    if(event.key === Qt.Key_Backspace && system.desktopPlatform) {
      backPressed()
    } else if(event.key === Qt.Key_Return) {
      enterPressed()
    }
  }

  Keys.onBackPressed: {
    backPressed()
  }

  Keys.onReturnPressed: {
    enterPressed()
  }
}

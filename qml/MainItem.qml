import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

Item {
  id: mainItem
  property alias audioManager: audioManager
  property alias entityManager: entityManager
  property alias gameNetwork: vplayGameNetworkScene.gameNetwork

  // for easier reference from GameOverScreen
  property int highscore: gameNetwork.userHighscoreForCurrentActiveLeaderboard
  property int coins

  // global music and sound management
  AudioManager {
    id: audioManager
  }

  MenuScene {
    id: menuScene
    onGamePressed: {
      mainItem.state = "game"
    }
    onNetworkPressed: {
      vplayGameNetworkScene.initialStateBeforeShow = "menu"
      mainItem.state = "gameNetwork"
    }

    onBackButtonPressed: {
      nativeUtils.displayMessageBox("Really quit the game?", "", 2);
    }

    Connections {
      // nativeUtils should only be connected, when this is the active scene
      target: window.activeScene === menuScene ? nativeUtils : null
      onMessageBoxFinished: {
        if(accepted) {
            Qt.quit()
        }
      }
    }
  }

  GameScene {
    id: gameScene

    onMenuPressed: {
      mainItem.state = "menu"
    }
    onNetworkPressed: {
      vplayGameNetworkScene.initialStateBeforeShow = "game"
      mainItem.state = "gameNetwork"
    }
    onUseCoinsPressed: {
    }
  }

  FelgoGameNetworkScene {
    id: vplayGameNetworkScene
    onBackButtonPressed: {
      // go back to the state from where it was called
      mainItem.state = vplayGameNetworkScene.initialStateBeforeShow
    }
  }

  EntityManager {
    id: entityManager
    // entities shall only be created in the gameScene
    entityContainer: gameScene.entityContainer
  }

  state: "menu"

  states: [
    State {
      name: "menu"
      PropertyChanges {target: menuScene; opacity: 1}
      PropertyChanges {target: window; activeScene: menuScene}
      StateChangeScript {
        script: {
          audioManager.play(audioManager.idSWOOSHING)
        }
      }
    },
    State {
      name: "gameNetwork"
      PropertyChanges {target: vplayGameNetworkScene; opacity: 1}
      PropertyChanges {target: window; activeScene: vplayGameNetworkScene}
    },
    State {
      name: "game"
      PropertyChanges {target: gameScene; opacity: 1}
      PropertyChanges {target: window; activeScene: gameScene}
      StateChangeScript {
        script: {
          gameScene.enterScene()
          audioManager.play(audioManager.idSWOOSHING)
        }
      }
    }
  ]
}

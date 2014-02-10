import VPlay 1.0
import QtQuick 1.1
import "scenes"
import "common"

GameWindow {
  id: window
  width: 320
  height: 480

  minimizeable: true

  // sceneLoader and managers should be available in every scene
  property alias window: window
  property alias audioManager: audioManager
  property alias entityManager: entityManager
  property alias gameNetwork: vplayGameNetworkScene.gameNetwork

  // for easier reference from GameOverScreen
  property int highscore: gameNetwork.userHighscoreForCurrentActiveLeaderboard

  // this is set to either "", "exitConfirmation" or "visitVPlayWebsite"
  // it is needed to distnguish which button caused the nativeUtils.displayMessageBox() call
  property string messageBoxInputState: ""

  contentScalingFileSuffixes: {
      "-sd": { "scaleThreshold": 1, "internalContentScaleFactor": 1 },
      // the original Flappy Bird graphics are only sd, so we scale them up on higher-res devices
      // for your game, design graphics for the highst resolution
      //"-hd": { "scaleThreshold": 2, "internalContentScaleFactor": 2 },
      //"-hd2": { "scaleThreshold": 2.5, "internalContentScaleFactor": 4}
    }

  // global music and sound management
  AudioManager {
    id: audioManager
  }

  MenuScene {
    id: menuScene
    onGamePressed: {
      window.state = "game"
    }
    onNetworkPressed: {
      vplayGameNetworkScene.initialStateBeforeShow = "menu"
      window.state = "gameNetwork"
    }

    onBackPressed: {
      messageBoxInputState = "exitConfirmation"
      nativeUtils.displayMessageBox("Really quit the game?", "", 2);
    }

    Connections {
      // nativeUtils should only be connected, when this is the active scene
      target: activeScene === gameScene ? nativeUtils : null
      onMessageBoxFinished: {
        if(accepted) {
          if(messageBoxInputState === "exitConfirmation") {
            Qt.quit()
          } else if(messageBoxInputState === "visitVPlayWebsite") {
            nativeUtils.openUrl("http://v-play.net/2014/02/how-to-make-a-flappy-bird-game/?utm_medium=game&utm_source=flappybird&utm_campaign=flappybird");
          }
        }

        messageBoxInputState = ""
      }
    }
  }

  GameScene {
    id: gameScene

    onMenuPressed: {
      window.state = "menu"
    }
    onNetworkPressed: {
      vplayGameNetworkScene.initialStateBeforeShow = "game"
      window.state = "gameNetwork"
    }
  }

  VPlayGameNetworkScene {
    id: vplayGameNetworkScene
    onBackPressed: {
      // go back to the state from where it was called
      window.state = vplayGameNetworkScene.initialStateBeforeShow
    }
  }

  EntityManager {
    id: entityManager
    // entities shall only be created in the gameScene
    entityContainer: gameScene.entityContainer
  }

  state: "menu"
  activeScene: menuScene

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

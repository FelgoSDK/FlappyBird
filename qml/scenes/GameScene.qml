import Felgo 3.0
import QtQuick 2.0
import "../game"
import "../common"
import "../entities"

SceneBase {
  id: scene

  property int score: 0

  property bool gameIsRunning: false
  property double gravityValue: 9.81 * 3

  property alias entityContainer: level

  signal menuPressed()
  signal networkPressed()
  signal useCoinsPressed()

  PhysicsWorld {
    id: physicsWorld

    gravity.y: gravityValue

    // for physics-based games, this should be set to 60!
    updatesPerSecondForPhysics: 60

    // this should be increased so it looks good, by default it is set to 1 to save performance
    velocityIterations: 5
    positionIterations: 5

    // by default debugDraw is visible in debug builds
    debugDrawVisible: false
  }

  Level {
    id: level
    anchors.fill: parent
  }

  Player {
    id: player
    resetX: parent.width/10*3
    resetY: parent.height/10*4
    onGameOver: {
      if(scene.state === "gameOver")
        return
      coins+=score
      scene.state = "gameOver"
      audioManager.play(audioManager.idDIE)
      audioManager.play(audioManager.idHIT)
    }
  }

  // displaying the score
  Numbers {
    anchors.horizontalCenter: parent.horizontalCenter
    y: 30
    number: score
  }

  // it's important to fill the gameWindowAnchorItem, so the whole screen is touch-able on any device with any aspect ratio
  MouseArea {
    id: mouseControl
    anchors.fill: scene.gameWindowAnchorItem
    onPressed: {
      if(gameIsRunning) {
        player.push()
      }
    }
  }

  // overlay on game over
  GameOverScreen {
    id: gameOverStats

    onPlayPressed: scene.state = "wait"
    onNetworkPressed: parent.networkPressed()
    onUseCoinsPressed: parent.useCoinsPressed()
  }

  // get-ready screen
  WaitScreen {
    id: waitToPlay
    onClicked: {
      scene.state = "play"
      player.push()
    }
  }

  onBackButtonPressed: {
    if(scene.state == "gameOver") mainItem.state = "menu"
    scene.state = "gameOver"
  }

  function enterScene() {
    state = "wait"
  }

  function exitScene() {
    menuPressed()
  }

  function initGame() {
    player.reset()
    level.reset()
    score = 0
  }

  function startGame() {
    level.start()
  }

  function stopGame() {
    level.stop()
  }

  function gameOver() {    
    stopGame()
    // do not submit a score of 0
    if(score > 0) {
      // submit the new score; if there is a new highscore, a signal onNewHighscore() is emitted by FelgoGameNetwork
      gameNetwork.reportScore(score)
    }
  }

  state: "wait"

  states: [
    State {
      name: "wait"
      PropertyChanges {target: waitToPlay; opacity: 1}
      PropertyChanges {target: physicsWorld; gravity: Qt.point(0,0)}

      StateChangeScript {
        script: {
          initGame()
        }
      }
    },
    State {
      name: "play"
      PropertyChanges {target: scene; gameIsRunning: true}
      PropertyChanges {target: physicsWorld; gravity: Qt.point(0,gravityValue)}
      StateChangeScript {
        script: {
          startGame()
        }
      }
    },
    State {
      name: "gameOver"
      PropertyChanges {target: gameOverStats; opacity: 1}
      PropertyChanges {target: physicsWorld; gravity: Qt.point(0,gravityValue*3)}
      StateChangeScript {
        script: {
          gameOver()
        }
      }
    }
  ]
}

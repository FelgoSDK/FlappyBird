import VPlay 1.0
import QtQuick 1.1
import "../game"
import "../common"
import "../entities"

SceneBase {
  id: scene

  property int score: 0

  property bool gameIsRunning: false
  property double gravityValue: -9.81*3

  property alias entityContainer: level

  signal menuPressed()
  signal networkPressed()


  PhysicsWorld {
    id: physicsWorld
    // this puts it on top of all other items for the physics debug renderer
    z: 1

    gravity.y: gravityValue

    // for physics-based games, this should be set to 60!
    updatesPerSecondForPhysics: 60

    // this should be increased so it looks good, by default it is set to 1 to save performance
    // when it is left at 1, the ball sometimes "float" into the wall or paddles
    velocityIterations: 5
    positionIterations: 5
    debugDrawVisible: true
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

      scene.state = "gameOver"
      audioManager.play(audioManager.idDIE)
      audioManager.play(audioManager.idHIT)
    }
  }

  Numbers {
    anchors.horizontalCenter: parent.horizontalCenter
    y: 40
    number: score
  }

  MouseArea {
    id: mouseControl
    anchors.fill: parent
    onClicked: {
      if(gameIsRunning) {
        player.push()
      }
    }
  }

  GameOverScreen {
    id: gameOverStats

    onPlayPressed: scene.state = "wait"
    onNetworkPressed: parent.networkPressed()
  }

  WaitScreen {
    id: waitToPlay
    onClicked: {
      scene.state = "play"
      player.push()
    }
  }

  onBackPressed: {
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
      // submit the new score; if there is a new highscore, a signal onNewHighscore() is emitted by VPlayGameNetwork
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

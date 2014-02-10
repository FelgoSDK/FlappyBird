import VPlay 1.0
import QtQuick 1.1

EntityBase {
  id: pipeElement
  width: spriteUpperPipe.width
  height: spriteUpperPipe.height+pipeGateway+spriteBottomPipe.height

  property int pipeGateway: 80
  property int variationDistance: 70
  property double delay: 0

  SingleSpriteFromFile {
    id: spriteUpperPipe
    translateToCenterAnchor: false
    filename: "../img/images-sd.json"
    source: "pipe_green.png"
    mirrorY: true
  }

  BoxCollider {
    id: collider
    width: spriteUpperPipe.width
    height: spriteUpperPipe.height
    anchors.centerIn: spriteUpperPipe
    bodyType: Body.Static
    collisionTestingOnlyMode: true
    fixture.onBeginContact: {
      player.gameOver()
    }
  }

  BoxCollider {
    width: 10
    height: pipeGateway
    y: spriteBottomPipe.height
    x: spriteBottomPipe.width/2
    bodyType: Body.Static
    collisionTestingOnlyMode: true
    fixture.onBeginContact: {
      gameScene.score++

      audioManager.play(audioManager.idPOINT)
    }
  }

  SingleSpriteFromFile {
    id: spriteBottomPipe
    y: height+pipeGateway
    translateToCenterAnchor: false
    filename: "../img/images-sd.json"
    source: "pipe_green.png"
  }

  BoxCollider {
    id: colliderBottomPipe
    width: spriteBottomPipe.width
    height: spriteBottomPipe.height
    anchors.centerIn: spriteBottomPipe
    bodyType: Body.Static
    collisionTestingOnlyMode: true
    fixture.onBeginContact: {
      player.gameOver()
    }
  }

  MovementAnimation {
    id: animation
    target: parent
    property: "x"
    velocity: -150
    running: false
    minPropertyValue: scene.gameWindowAnchorItem.x-pipeElement.width*1.5
    onLimitReached: {
      reset()
    }
  }

  Utils {
    id: utils
  }

  function reset() {
    var animationIsRunning = animation.running
    if(animationIsRunning)
      stop()

    pipeElement.x = scene.gameWindowAnchorItem.width+pipeElement.width/2
    pipeElement.y = utils.generateRandomValueBetween(-variationDistance, variationDistance)-scene.height/3

    if(animationIsRunning)
      animation.start()
  }

  function start() {
    delayTimer.restart()
  }

  function stop() {
    animation.stop()
    delayTimer.stop()
  }

  Timer {
    id: delayTimer
    interval: delay*1000
    repeat: false
    onTriggered: {
      animation.start()
    }
  }

  Component.onCompleted: {
    reset()
  }
}

import QtQuick 2.0
import Felgo 3.0


EntityBase {
  id: player
  entityType: "player"

  property real upwardforce: -280
  property int resetX: 0
  property int resetY: 0

  width: collider.radius * 2
  height: collider.radius * 2

  signal gameOver()

  Component.onCompleted: reset()

  onGameOver: {
    spriteSequence.running = false
  }

  SpriteSequence {
    id: spriteSequence

    anchors.centerIn: parent

    Sprite {
      name: "idle"
      frameCount: 3
      frameRate: 10

      frameWidth: 34
      frameHeight: 24
      source: "../../assets/img/birdSprite.png"
    }
    rotation: wabbleX.running ? 0 : collider.linearVelocity.y/10
  }

  CircleCollider {
    id: collider

    radius: spriteSequence.height/2
    bodyType: Body.Dynamic
  }

  function reset() {
    player.x = resetX
    player.y = resetY
    collider.body.linearVelocity = Qt.point(0,0)
    activateWabbling()
    spriteSequence.running = true
  }

  function push() {
    wabbleX.stop()
    wabbleY.stop()
    audioManager.play(audioManager.idWING)
    collider.body.linearVelocity = Qt.point(0,0)
    var localForwardVector = collider.body.toWorldVector(Qt.point(0, upwardforce));
    collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
  }

  NumberAnimation on x {running: false; id: wabbleX; duration: 4000; loops: Animation.Infinite; easing.type: Easing.CosineCurve}
  NumberAnimation on y {running: false; id: wabbleY; duration: 4000; loops: Animation.Infinite; easing.type: Easing.SineCurve}

  function activateWabbling() {
    var wableVal = 25
    var rand = Math.random()
    var dir = (rand < 0.5 ? -wableVal/4*rand : wableVal/4*rand )
    wabbleX.from = player.x+dir
    wabbleX.to = player.x-dir
    wabbleX.start()
    rand = Math.random()
    dir = (rand < 0.5 ? -wableVal*rand : wableVal*rand )
    wabbleY.from = player.y+dir
    wabbleY.to = player.y-dir
    wabbleY.start()
  }
}

import VPlay 1.0
import QtQuick 1.1

EntityBase {
  id: player
  entityType: "player"

  property int upwardforce: -280
  property int resetX: 0
  property int resetY: 0

  signal gameOver()

  Component.onCompleted: reset()

  onGameOver: {
    spriteSequence.running = false
  }

  SpriteSequenceFromFile {
    id: spriteSequence
    filename: "../img/images-sd.json"

    Sprite {
      name: "idle"
      frameNames: [
        "bird_0.png",
        "bird_1.png",
        "bird_2.png",
      ]
      frameCount: 3
      frameRate: 10
    }
  }

  CircleCollider {
    id: collider

    radius: spriteSequence.height/2
    anchors.centerIn: parent

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
    var localForwardVector = collider.body.getWorldVector(Qt.point(0,upwardforce));
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

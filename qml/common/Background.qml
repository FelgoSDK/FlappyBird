import Felgo 3.0
import QtQuick 2.0

Item {
  width: bg.width
  height: bg.height
  MultiResolutionImage {
    id: bg
    source: "../../assets/img/bg.png"


  }
  MultiResolutionImage {
    id: rotor
    source: "../../assets/img/rotor.png"
    x: 178
    y: 318
  }

  MovementAnimation {
    target: rotor
    property: "rotation"
    velocity: 90
    running: true
  }
}

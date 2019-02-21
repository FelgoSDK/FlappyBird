import Felgo 3.0
import QtQuick 2.0
import "../entities"

Item {
  id: numbers
  width: row.width
  height: row.heigth
  property string color
  property int number: 0

  property string imagePath: "../../assets/img/"

  function truncate(_value)
  {
    if (_value<0) return Math.ceil(_value);
    else return Math.floor(_value);
  }

  onNumberChanged: {
    if(number > 9999) number = 9999
    var trailingZero = true

    var unit = truncate((number / 1000) % 10)
    if((trailingZero && unit <= 0) || unit >= 10) {
      position1000.source = imagePath + "empty_big.png"
    } else {
      trailingZero = false
      position1000.source = imagePath + unit+"_big"+color+".png"
    }

    unit = truncate((number / 100) % 10)
    if((trailingZero && unit <= 0) || unit >= 10) {
      position100.source = imagePath + "empty_big.png"
    } else {
      trailingZero = false
      position100.source = imagePath + unit+"_big"+color+".png"
    }

    unit = truncate((number / 10) % 10)
    if((trailingZero && unit <= 0) || unit >= 10) {
      position10.source = imagePath + "empty_big.png"
    } else {
      position10.source = imagePath + unit+"_big"+color+".png"
    }

    unit = truncate(number % 10)
    // test also if there is remainder, if no remainder it might be 10 and the first number is needed, otherwise a fragment is displayed.
    if(number % 10 && ((trailingZero && unit <= 0) || unit >= 10)) {
      position1.source = imagePath + "empty_big.png"
    } else {
      position1.source = imagePath + unit+"_big"+color+".png"
    }

    if(number <= 0) {
      position1.source = imagePath + "0_big"+color+".png"
    }
  }

  Row {
    id: row
    height: position1.height
    x: number >= 1000 ? -12 : number >= 100 ? -24 : number >= 10 ? -36 : -48

    MultiResolutionImage {
      id: position1000
      source: imagePath + "empty_big.png"
    }
    MultiResolutionImage {
      id: position100
      source: imagePath + "empty_big.png"
    }
    MultiResolutionImage {
      id: position10
      source: imagePath + "empty_big.png"
    }

    MultiResolutionImage {
      id: position1
      source: imagePath + "0_big"+color+".png"
    }
  }
}

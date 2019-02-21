import Felgo 3.0
import QtQuick 2.0

Item {
  id: audioManager

  // Use Sound IDs to play Sounds e.g. audioManager.play(audioManager.idDIE)
  property int idDIE: 11
  property int idHIT: 22
  property int idPOINT: 33
  property int idSWOOSHING: 44
  property int idWING: 55


  function play(clipID) {

    switch(clipID) {
    case idDIE:
      die.play()
      break
    case idHIT:
      hit.play()
      break
    case idPOINT:
      point.play()
      break
    case idSWOOSHING:
      swoosh.play()
      break
    case idWING:
      wing.play()
      break
    }
  }

  SoundEffect {
    id: die
    source: "../../assets/audio/sfx_die.wav"
  }
  SoundEffect {
    id: hit
    source: "../../assets/audio/sfx_hit.wav"
  }
  SoundEffect {
    id: point
    source: "../../assets/audio/sfx_point.wav"
  }
  SoundEffect {
    id: swoosh
    source: "../../assets/audio/sfx_swooshing.wav"
  }
  SoundEffect {
    id: wing
    source: "../../assets/audio/sfx_wing.wav"
  }
}

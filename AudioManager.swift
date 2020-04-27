import AVFoundation
import SpriteKit
class AudioManager {
  static let instance = AudioManager()
    private init(){}
    private var audioPlayer: AVAudioPlayer?
    func playBGMusic(){
      let url = Bundle.main.url(forResource: "Blackmoor Ninjas", withExtension: "mp3")
        do {
         try audioPlayer = AVAudioPlayer(contentsOf: url!)
             audioPlayer?.numberOfLoops = -1
             audioPlayer?.prepareToPlay()
             audioPlayer?.play()
        } catch let err1 as NSError {
          print(err1.debugDescription)
        }
    }
    func stopBgMusic(){
        if (audioPlayer?.isPlaying)!{
         audioPlayer?.stop()
        }
    }
    func isAudioPlayerInitialzed()-> Bool{
    return audioPlayer == nil
    }
}

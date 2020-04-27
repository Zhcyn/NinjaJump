import Foundation
import Social
import UIKit
import SpriteKit
class Social : SKScene {
    static let shared = Social()
    func shareFB(){
        let post = SLComposeViewController(forServiceType:SLServiceTypeFacebook)!
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
        {
            post.add(URL(string: "itms-apps://itunes.apple.com/app/id1510280752"))
            post.setInitialText("My Score on Ninja game is : "+String(GamePlayController.instace.score!)+" Download From Here : itms-apps://itunes.apple.com/app/id1510280752 ")
            self.view?.window?.rootViewController?.present(post, animated: true, completion: nil)
        } else {
            self.showAlert(service: "Facebook")
        }
    }
    func shareTwitter(){
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let vc = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
            vc?.add(URL(string: "itms-apps://itunes.apple.com/app/id1510280752"))
            vc?.setInitialText("My Score on Ninja game is : "+String(GamePlayController.instace.score!)+" Download From Here : itms-apps://itunes.apple.com/app/id1510280752 ")
            self.view?.window?.rootViewController?.present(vc!, animated: true, completion: nil)
        } else {
            self.showAlert(service: "Twitter")
        }
    }
    func showAlert(service:String)
    {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

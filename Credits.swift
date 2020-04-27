import Foundation
import SpriteKit
import UIKit
import MessageUI

class Credits : SKScene, MFMailComposeViewControllerDelegate{
    var ninga : SKSpriteNode?
    private var textureAtlas = SKTextureAtlas()
    
    private var NinjaAnimation = [SKTexture]()
    private var animateNinjaAction = SKAction()
    var animateForever = SKAction()
  

    override func didMove(to view: SKView) {
        scene?.scaleMode = SKSceneScaleMode.resizeFill
        animateNinja()
                
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "rate" {
                
                rateApp()
                UIApplication.shared.openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1510280752")! as URL)
                
                print("app rated")
                
            }


        
        if atPoint(location).name == "Back button" {
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
        }
            if atPoint(location).name == "share" {
                
                
                    let message = "Download the Amazing Game : Ninja Jump from the AppStore : itms-apps://itunes.apple.com/app/id1510280752 "
                
                    if let link = NSURL(string: "https//itunes.apple.com/app/id1510280752")
                    {
                        let objectsToShare = [message,link] as [Any]
                        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
                        self.view?.window?.rootViewController?.present(activityVC, animated: true, completion: nil)
                    }
                print("shared")
            }
                  
    }

}
    func animateNinja(){
        
        ninga = childNode(withName: "ninja") as! SKSpriteNode?
        textureAtlas = SKTextureAtlas(named: "Player")
        for i in 1...9{
            let name = "Idle__00\(i)"
            
            NinjaAnimation.append(SKTexture(imageNamed : name))
            
        }
        animateNinjaAction = SKAction.animate(with: NinjaAnimation, timePerFrame: 0.08)
        animateForever = SKAction.repeatForever(animateNinjaAction)
        ninga?.run(animateForever)
        
        
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
       
        controller.dismiss(animated: true, completion: nil)
    }
    
    func rateApp(){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string : "itms-apps://itunes.apple.com/app/id1510280752")!, options: [:]) { (done) in
                // Handle results
                
            }
        } else {
            // Fallback on earlier versions
        }}
} // Class

import UIKit
import SpriteKit
import GameplayKit
import UserNotifications
class GameViewController: UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (auth, error) in
            if !auth {
                print("app is not allow to Use notifiation")
            }
        }
        if let view = self.view as! SKView? {
            if let scene = MainMenuScene(fileNamed: "MainMenu") {
                scene.scaleMode = .aspectFill   
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
        notification()
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        }
    func notification(){
        let center = UNUserNotificationCenter.current()
        let date = Date(timeIntervalSinceNow: 3600)
        let content = UNMutableNotificationContent()
        content.title = "Let's Play NinjaJump"
        content.body = "it's time to Play : NinjaJump"
        content.sound = UNNotificationSound.default()
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}

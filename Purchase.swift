import SpriteKit
import StoreKit
import CloudKit
import UIKit
class Purchase : SKScene {
    let bundelID = "com.J64.NinjaJump"
     var activityIndecator : UIActivityIndicatorView = UIActivityIndicatorView()
    var list = [SKProduct]()
    var p = SKProduct()
    var product = SKProduct()
    var productID : String?
    var lbale : SKLabelNode?
    var desc : SKLabelNode?
    var removeAdsBtn : SKSpriteNode?
    private var CoinLable : SKLabelNode?
    let id = "com.J64.NinjaJump.RemoveAds"
    let addCoinID = "com.J64.NinjaJump.Add100Coin"
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "Back button" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
            }
            if atPoint(location).name == "ads1" {
                print("rem ads")
                for product in list {
                    let prodID = product.productIdentifier
                    if(prodID == "com.J64.NinjaJump.RemoveAds") {
                        p = product
                        buyProduct()
                    }
                }
            }
             if atPoint(location).name == "restore" {
                StoreManager.instance.restoreRemoveAds { success in
                    if success {
                        print("sucess restore")
                        let alert = UIAlertController(title: "Purchases Restored", message: "All purchases have been restored.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                      self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }else {
                        let alert = UIAlertController(title: "Nothing To Restore", message: "No previous purchases were made", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    override func didMove(to view: SKView) {
        getRefrence()
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            let productID: NSSet = NSSet(objects: "com.J64.NinjaJump.RemoveAds")
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
    }
    private func getRefrence(){
        lbale?.childNode(withName: "labl")
        desc?.childNode(withName: "Description")
        removeAdsBtn?.childNode(withName: "ads")
        CoinLable = self.childNode(withName: "Coin label") as! SKLabelNode?
        CoinLable?.text = String(GameManager.instance.getMediumDefficultyCoinScore())
    }
    func activity(){
        activityIndecator.center = (self.view?.center)!
        activityIndecator.hidesWhenStopped = true
        activityIndecator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view?.addSubview(activityIndecator)
        activityIndecator.startAnimating()
    }
    func buyProduct() {
        print("buy " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
    }
}

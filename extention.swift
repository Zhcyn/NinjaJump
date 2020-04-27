import Foundation
import StoreKit
extension Purchase : SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("add payment")
        for transaction: AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            switch trans.transactionState {
            case .purchased:
                print("buy ok, unlock IAP HERE")
                print(p.productIdentifier)
                let prodID = p.productIdentifier
                switch prodID {
                case "com.J64.NinjaJump.RemoveAds":
                    print("remove ads")
                    UserDefaults.standard.set(true, forKey: id)
                case "seemu.iap.addcoins":
                    print("add coins to account")
                default:
                    print("IAP not found")
                }
                queue.finishTransaction(trans)
            case .failed:
                print("buy error")
                queue.finishTransaction(trans)
                break
            default:
                print("Default")
                break
            }
        }
    }
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            list.append(product)
        }
    }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transactions restored")
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            switch prodID {
            case "com.J64.NinjaJump.RemoveAds":
                print("remove ads")
                UserDefaults.standard.set(true, forKey: id)
            case "seemu.iap.addcoins":
                print("add coins to account")
            default:
                print("IAP not found")
            }
        }
    }
} 

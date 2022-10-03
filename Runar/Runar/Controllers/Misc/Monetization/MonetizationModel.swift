//
//  MonetizationModel.swift
//  Runar
//
//  Created by George Stupakov on 21/07/2022.
//

import Foundation
import StoreKit

enum IAPSubscriptions: String, CaseIterable {

    case premiumSubscription = "com.tnco.runar.premiumSubscription"
    case popularSubscription = "com.tnco.runar.popularSubscription"
    case eternalSubscription = "com.tnco.runar.eternalSubscription"
}

class MonetizationModel: NSObject {

    internal var subscription: Set<String> = [IAPSubscriptions.popularSubscription.rawValue]
    
    internal func getSubscription() {
        if SKPaymentQueue.canMakePayments() {
            let subscriptionRequest = SKProductsRequest(productIdentifiers: subscription)
            subscriptionRequest.delegate = self
            subscriptionRequest.start()
        }
    }
    
    private func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }

    internal func restorePurchase() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    private func purchaseChanges() {
        SubscriptionManager.freeSubscription = false
        UserDefaults.standard.set(true, forKey: "subscribed")
        //self.dismiss(animated: true, completion: nil)
    }
}

extension MonetizationModel: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        if let product = response.products.first {
            print("\(product.localizedTitle) is available!")
            self.purchase(product: product)
        } else {
            print("Product is not available!")
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                case .purchased:
                    purchaseChanges()
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("Transaction successful")
                case .failed:
                    if let error = transaction.error {
                        print("Transaction failed due to \(error.localizedDescription)")
                    }
                    SKPaymentQueue.default().finishTransaction(transaction)
                case .restored:
                    purchaseChanges()
                    print("Transaction restored")
                    SKPaymentQueue.default().finishTransaction(transaction)
                default: break
            }
        }
    }
}

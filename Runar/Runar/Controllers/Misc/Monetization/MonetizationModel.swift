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
}

extension MonetizationModel: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        if let product = response.products.first {
            print("\(product.localizedTitle) is available!")
            self.purchase(product: product)
        } else {
            print("product is not available!")
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                case .purchasing:
                    print("customer in the process of purchase")
                case .purchased:
                    //remove some blocks
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("Transaction successful")
                case .failed:
                    if let error = transaction.error {
                        print("Transaction failed due to \(error.localizedDescription)")
                    }
                    SKPaymentQueue.default().finishTransaction(transaction)
                case .restored:
                    //remove some blocks
                    print("Transaction restored")
                    SKPaymentQueue.default().finishTransaction(transaction)
                case .deferred:
                    print("deferred")
                default: break
            }
        }
    }
}

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
}


extension MonetizationModel: SKProductsRequestDelegate { //, SKPaymentTransactionObserver
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        for product in response.products {
            print(product.localizedTitle)
        }
    }
//
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        <#code#>
//    }
}

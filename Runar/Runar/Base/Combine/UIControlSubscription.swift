//
//  UIControlSubscription.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import Combine
import UIKit

public extension UIControl {
    final class Subscription<SubscriberType, Control>: Combine.Subscription where SubscriberType: Subscriber, Control: UIControl, SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private let control: Control
        
        public init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        public func request(_ demand: Subscribers.Demand) {
            // Empty
        }
        
        public func cancel() {
            subscriber = nil
        }
        
        @objc
        private func handleEvent() {
            _ = subscriber?.receive(control)
        }
    }
}

//
//  UIControlPublisher.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import Combine
import UIKit

public extension UIControl {
    struct Publisher<Control>: Combine.Publisher where Control: UIControl {
        public typealias Output = Control
        public typealias Failure = Never
        
        private let control: Control
        private let events: UIControl.Event
        
        public init(control: Control, events: UIControl.Event) {
            self.control = control
            self.events = events
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, control: control, event: events)
            subscriber.receive(subscription: subscription)
        }
    }
}

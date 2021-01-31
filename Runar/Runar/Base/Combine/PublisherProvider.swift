//
//  PublisherProvider.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import Combine
import UIKit

protocol PublisherProvider { }

extension UIControl: PublisherProvider { }

extension PublisherProvider where Self: UIControl {
    func publisher(for events: UIControl.Event) -> Publisher<Self> {
        Publisher(control: self, events: events)
    }
    
    func voidPublisher(for events: UIControl.Event) -> Publishers.Map<Publisher<Self>, Void> {
        Publisher(control: self, events: events).map { _ -> Void in }
    }
    
    func tapPublisher() -> Publishers.Map<Publisher<Self>, Void> {
        voidPublisher(for: .touchUpInside)
    }
}

extension PublisherProvider where Self: UITextField {
    func optionalTextPublisher() -> Publishers.Map<Publisher<Self>, String?> {
        publisher(for: .editingChanged).map { $0.text }
    }
    
    func textPublisher() -> Publishers.Map<Publisher<Self>, String> {
        optionalTextPublisher().map { $0 ?? "" }
    }
}

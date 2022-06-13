//
//  ProcessingVM.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.02.21.
//

import Foundation

public class ProcessingVM {
    public let name: String
    public let title: String?
    
    public let closeTransition: () -> Void
    public init (name: String, title: String?, closeTransition: @escaping () -> Void) {
        self.name = name
        self.title = title
        self.closeTransition = closeTransition
    }
}

//
//  BindableGestureRecognizer.swift
//  Runar
//
//  Created by George Stupakov on 04/09/2022.
//

import UIKit

final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action()
    }
}

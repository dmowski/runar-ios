//
//  ApiGeneratorModel.swift
//  Runar
//
//  Created by George Stupakov on 22/05/2022.
//

import UIKit

struct ApiGeneratorModel {
    
    static func generateRandomeWallpapersModel(vc: UIViewController, runesIds: [String]) {
        let viewModel = ProcessingViewModel(name: .progressName, title: .progressTitle) {
            if vc.navigationController?.topViewController is ProcessingViewController {
                vc.navigationController?.popViewController(animated: true)
            }
        }
        
        let processCV = ProcessingViewController()
        processCV.viewModel = viewModel
        processCV.runesIds = runesIds
        processCV.delegate = vc
        processCV.ifGenerateWallpapers = true
        processCV.container.isHidden = false
        vc.navigationController?.pushViewController(processCV, animated: true)
    }
}

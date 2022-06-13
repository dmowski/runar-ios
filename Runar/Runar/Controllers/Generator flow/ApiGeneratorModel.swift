//
//  ApiGeneratorModel.swift
//  Runar
//
//  Created by George Stupakov on 22/05/2022.
//

import UIKit

struct ApiGeneratorModel {
    
    static func showProcessingVCandGenerateImagesModel(vc: UIViewController, runesIds: [String]) {
        let viewModel = ProcessingViewModel(name: .progressName, title: .generateProgressTitle) {
            if vc.navigationController?.topViewController is ProcessingViewController {
                vc.navigationController?.popViewController(animated: true)
            }
        }
        
        let processCV = ProcessingViewController()
        processCV.viewModel = viewModel
        processCV.runesIds = runesIds
        processCV.delegate = vc
        let duration = 10
        processCV.changeAnimationDuration(duration: duration)
        processCV.ifGenerateWallpapers = true
        processCV.container.isHidden = false
        vc.navigationController?.pushViewController(processCV, animated: true)
    }
}

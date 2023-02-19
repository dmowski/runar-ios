//
//  ApiGeneratorModel.swift
//  Runar
//
//  Created by George Stupakov on 22/05/2022.
//

import UIKit

struct ApiGeneratorModel {
    
    static func showProcessingVCandGenerateImagesModel(vc: UIViewController, runesIds: [String]) {
        let viewModel = ProcessingVM(name: .progressName, title: .generateProgressTitle) {}
        
        let processCV = ProcessingVC()
        processCV.viewModel = viewModel
        processCV.runesIds = runesIds
        processCV.delegate = vc
        processCV.ifGenerateWallpapers = true
        vc.navigationController?.pushViewController(processCV, animated: true)
    }
}

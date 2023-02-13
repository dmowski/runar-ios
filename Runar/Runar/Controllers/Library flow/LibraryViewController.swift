//
//  LibraryRootViewModel.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/16/21.
//

import UIKit

final class LibraryViewController: LibraryNodeViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        set(MemoryStorage.Library)
        coreDataTestFunction()
    }
    
    override func configureNavigationBar() {
        title = .library
        navigationController?.navigationBar.configureTitle()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: L10n.Navbar.Title.back, style: .plain, target: nil, action: nil)
        
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }
   
    // TODO: - Should be delete after testing
    private func coreDataTestFunction() {
        let urlString = "https://runar-java-back.herokuapp.com/api/v2/"
        guard let url = URL(string: urlString) else { return }
        
        let networkServise = APIClient<[RuneModel]>()
        let coreDataService: PesistenceService = CoreDataService()
        
        Task.init {
            let runes = try await networkServise.fetch(from: url)
            
            coreDataService.addUpdateRune(runes[0]) { result in
                switch result {
                case .success(_):
                    print("Rune \(runes[0]) has been saved(updated)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

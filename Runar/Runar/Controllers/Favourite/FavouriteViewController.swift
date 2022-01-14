//
//  FavouriteViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 12/23/21.
//

import UIKit

public class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
        
    // MARK: - Override funcs
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view)
        
        configureNodeView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        title = "Избранное"
        
        navigationController?.navigationBar.configure(prefersLargeTitles: true, titleFontSize: 34)
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }
    
    private func configureNodeView() -> Void {
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Need to customize
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

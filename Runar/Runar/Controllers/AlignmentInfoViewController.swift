//
//  AlignmentInfoViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 19.12.20.
//

import UIKit

class AlignmentInfoViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonCloseOnTap(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}


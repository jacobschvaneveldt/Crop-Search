//
//  DocumentsTableViewController.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 9/6/21.
//

import UIKit

class DocumentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.documentsTitle
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.addTarget(self, action: #selector(goToMainVC), for: .touchUpInside)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    

    let button: UIButton = {
       let button = UIButton()
        button.setTitle(Strings.nextViewButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    @objc func goToMainVC() {
        navigationController?.pushViewController(CoolerRiskViewController(), animated: true)
    }
    
}

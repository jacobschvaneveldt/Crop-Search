//
//  CoolerTableViewCell.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 8/23/21.
//

import UIKit

class CoolerTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(commentButton)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commentButton.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
    }
    
    //MARK: - PROPERTIES
    var cells: [String] = [Strings.cellOne, Strings.cellTwo, Strings.cellThree, Strings.cellFour, Strings.cellFive]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - FUNCTIONS
    
    
    
    //MARK: - VIEWS
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus.bubble"), for: .normal)
        button.imageView?.tintColor = .orange
        button.clipsToBounds = true
        return button
    }()
    
    
    let segmentedController: UISegmentedControl = {
       let items = ["Acceptable", "Unacceptable", "N/A"]
        let sc = UISegmentedControl(items: items)
        sc.layer.cornerRadius = 15
                
        return sc
        
        
    }()
    
    let commentTextField = UITextField()
    let commentTextLabel = UILabel()
}

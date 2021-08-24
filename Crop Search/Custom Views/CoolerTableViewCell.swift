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
        
        addSubview(coolerTextLabel)
        addSubview(commentButton)
        addSubview(segmentedController)
        addSubview(commentTextField)
        addSubview(commentTextLabel)
        
        configureCoolerTextLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coolerTextLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 0)
    }
    
    //MARK: - PROPERTIES
    var cells: [String] = [Strings.cellOne, Strings.cellTwo, Strings.cellThree, Strings.cellFour, Strings.cellFive]

    var safeArea: UILayoutGuide {
        self.contentView.safeAreaLayoutGuide
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - FUNCTIONS
    func configureCoolerTextLabel() {
        coolerTextLabel.numberOfLines = 0
        coolerTextLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func set(cells: String) {
        coolerTextLabel.text = cells
    }
    
    //MARK: - VIEWS
    
    let coolerTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        
        return label
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus.bubble"), for: .normal)
        button.imageView?.tintColor = .orange
        
        return button
    }()
    
    
    let segmentedController = UISegmentedControl()
    let commentTextField = UITextField()
    let commentTextLabel = UILabel()
    
}

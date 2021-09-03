//
//  CustomTableViewCell.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 8/26/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        segmentedController.addTarget(self, action: #selector(change), for: .allEvents)
        commentButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 16, paddingRight: 0, width: titleLabel.frame.width, height: contentView.frame.height)
        
        titleLabel.frame = CGRect(x: 16, y: contentView.frame.height / 2 - titleLabel.frame.height / 2, width: titleLabel.frame.width, height: titleLabel.frame.height)
        
        commentButton.frame = CGRect(x: contentView.frame.width - commentButton.frame.width - segmentedController.frame.width - 32, y: contentView.frame.height / 2 - commentButton.frame.height / 2, width: contentView.frame.height / 2, height: contentView.frame.height / 2.3)
        
        segmentedController.frame = CGRect(x: contentView.frame.width - segmentedController.frame.width - 16, y: contentView.frame.height / 2 - segmentedController.frame.height / 2, width: segmentedController.frame.width, height: segmentedController.frame.height)
        
        //TODO - add comment text field
    }
    
    //MARK: - FUNCTIONS
    func addAllSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(commentButton)
        contentView.addSubview(segmentedController)
        contentView.addSubview(commentTextView)
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    @objc func change(sender: UISegmentedControl) {
        if segmentedController.selectedSegmentIndex == 0 {
            segmentedController.selectedSegmentTintColor = .systemGreen
        } else if segmentedController.selectedSegmentIndex == 1 {
            segmentedController.selectedSegmentTintColor = .systemRed
        } else {
            segmentedController.selectedSegmentTintColor = .gray
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        print("button is tapped")
    }
    
    //MARK: - VIEWS
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        return titleLabel
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .orange
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private let segmentedController: UISegmentedControl = {
        let items = ["Acceptable", "Unacceptable", "N/A"]
        let sc = UISegmentedControl(items: items)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        sc.clipsToBounds = true
        return sc
    }()
    
    private let commentTextView: UITextField = {
       let utf = UITextField()
        utf.backgroundColor = .blue
        utf.clipsToBounds = true
        
        return utf
    }()
}

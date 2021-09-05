//
//  CustomTableViewCell.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 8/26/21.
//

import UIKit

protocol cellUpdate: AnyObject {
    func updateTableView(cell: CustomTableViewCell)
    func getSC(cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    
    
    static let identifier = "CustomTableViewCell"
    static var buttonTapped = false
    weak var delegate: cellUpdate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        segmentedController.addTarget(self, action: #selector(change), for: .valueChanged)
        commentButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setupVerStackView()
        setupHorStackView()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        verticalStackView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        horizontalStackView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height / 2)
        
        titleLabel.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 16, paddingRight: 0, width: titleLabel.frame.width, height: contentView.frame.height)
        
        titleLabel.frame = CGRect(x: 16, y: horizontalStackView.frame.height / 2 - titleLabel.frame.height / 2, width: titleLabel.frame.width, height: titleLabel.frame.height)
        
        commentButton.frame = CGRect(x: horizontalStackView.frame.width - commentButton.frame.width - segmentedController.frame.width - 32, y: horizontalStackView.frame.height / 2 - commentButton.frame.height / 2, width: commentButton.frame.width, height: commentButton.frame.height)
        
        segmentedController.frame = CGRect(x: horizontalStackView.frame.width - segmentedController.frame.width - 16, y: horizontalStackView.frame.height / 2 - segmentedController.frame.height / 2, width: segmentedController.frame.width, height: segmentedController.frame.height)
        
    }
    
    //MARK: - FUNCTIONS
    func addAllSubviews() {
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(verticalStackView)
    }
    
    func setupVerStackView() {
        verticalStackView.addSubview(horizontalStackView)
        verticalStackView.addSubview(commentTextField)
    }
    
    func setupHorStackView() {
        horizontalStackView.addSubview(titleLabel)
        horizontalStackView.addSubview(commentButton)
        horizontalStackView.addSubview(segmentedController)
    }
    
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    @objc func change(sender: UISegmentedControl) {
        getSC()
        if segmentedController.selectedSegmentIndex == 0 {
            segmentedController.selectedSegmentTintColor = .systemGreen
        } else if segmentedController.selectedSegmentIndex == 1 {
            segmentedController.selectedSegmentTintColor = .systemRed
        } else {
            segmentedController.selectedSegmentTintColor = .gray
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        updateViews()
    }
    
    func updateViews() {
        delegate?.updateTableView(cell: self)
    }
    
    func getSC() {
        delegate?.getSC(cell: self)
    }
    
    func setupTextField() {
        commentTextField.anchor(top: horizontalStackView.bottomAnchor, bottom: verticalStackView.bottomAnchor, leading: verticalStackView.leadingAnchor, trailing: verticalStackView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 16, paddingRight: 16)
        commentTextField.isHidden = true
//        updateViews()
    }
    
    func setupCommentLabel() {
        commentTextLabel.anchor(top: horizontalStackView.bottomAnchor, bottom: verticalStackView.bottomAnchor, leading: verticalStackView.leadingAnchor, trailing: verticalStackView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 16, paddingRight: 16)
        commentTextLabel.isHidden = true
//        updateViews()
    }
    
    func setCommentLabel(comment: String) {
        commentTextLabel.text = comment
    }
    
    //MARK: - VIEWS
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        return titleLabel
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        if buttonTapped == false {
            button.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "multiply"), for: .normal)
        }
        
        button.backgroundColor = .clear
        button.tintColor = .orange
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .fill
        button.sizeToFit()
        
        return button
    }()
    
    let segmentedController: UISegmentedControl = {
        let items = ["Acceptable", "Unacceptable", "N/A"]
        let sc = UISegmentedControl(items: items)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        sc.clipsToBounds = true
        return sc
    }()
    
    let commentTextField: UITextField = {
        let ctf = UITextField()
        ctf.backgroundColor = .systemBackground
        ctf.clipsToBounds = true
        ctf.sizeToFit()
        ctf.layer.cornerRadius = 15
        ctf.layer.borderWidth = 1
        
        return ctf
    }()
    
    private let horizontalStackView: UIStackView = {
        let hsv = UIStackView()
        hsv.axis = .horizontal
        
        return hsv
    }()
    
    private let verticalStackView: UIStackView = {
        let vsv = UIStackView()
        vsv.axis = .vertical
        
        return vsv
    }()
    
    private let commentTextLabel: UILabel = {
        let ctl = UILabel()
        ctl.backgroundColor = .cyan
        ctl.textColor = .red
        ctl.textAlignment = .left
        
        return ctl
    }()
}

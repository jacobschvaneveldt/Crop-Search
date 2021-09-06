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
    func showCommentTextLabel(cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    
    
    static let identifier = "CustomTableViewCell"
    static var buttonTapped = 1
    weak var delegate: cellUpdate?
    var user = "Eric Engman"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        segmentedController.addTarget(self, action: #selector(change), for: .valueChanged)
        commentButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        commentButton2.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        commentTextField.addTarget(self, action: #selector(textDidChange(textfield:)), for: .editingDidEnd)
        setupVerStackView()
        setupHorStackView()
        setupTextField()
        setupCommentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        verticalStackView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        
        ///The height is explicitly set here because that is the height of the cell initially
        horizontalStackView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 50)
                
        titleLabel.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 16, paddingRight: 0, width: titleLabel.frame.width, height: contentView.frame.height)
        
        titleLabel.frame = CGRect(x: 16, y: horizontalStackView.frame.height / 2 - titleLabel.frame.height / 2, width: titleLabel.frame.width, height: titleLabel.frame.height)
        
        commentButton.frame = CGRect(x: horizontalStackView.frame.width - commentButton.frame.width - segmentedController.frame.width - 32, y: horizontalStackView.frame.height / 2 - commentButton.frame.height / 2, width: commentButton.frame.width, height: commentButton.frame.height)
        
        commentButton2.frame = CGRect(x: horizontalStackView.frame.width - commentButton.frame.width - segmentedController.frame.width - 32, y: horizontalStackView.frame.height / 2 - commentButton.frame.height / 2, width: commentButton.frame.width, height: commentButton.frame.height)

        
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
        verticalStackView.addSubview(commentTextLabel)
    }
    
    func setupHorStackView() {
        horizontalStackView.addSubview(titleLabel)
        horizontalStackView.addSubview(commentButton)
        horizontalStackView.addSubview(commentButton2)
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
        
        if commentTextLabel.text != nil {
            commentTextField.text = commentTextLabel.text
        }
    }
    
    @objc func textDidChange(textfield: UITextField) {
        let date = Date()
        let dateString = DateFormatter.deviceTime.string(from: date)
        let comment = commentTextField.text
        commentTextLabel.text = "\(user) on \(dateString): \(comment!)"
        commentTextField.isHidden.toggle()
        commentTextLabel.isHidden.toggle()
        commentButton.isHidden.toggle()
        commentButton2.isHidden.toggle()
    }
    
    func updateViews() {
        delegate?.updateTableView(cell: self)
    }
    
    func getSC() {
        delegate?.getSC(cell: self)
    }
    
    func setupTextField() {
        commentTextField.anchor(top: horizontalStackView.bottomAnchor, bottom: verticalStackView.bottomAnchor, leading: verticalStackView.leadingAnchor, trailing: verticalStackView.trailingAnchor, paddingTop: 0, paddingBottom: -commentTextField.frame.height / 2.1, paddingLeft: 16, paddingRight: 16)
        commentTextField.isHidden = true
    }
    
    func setupCommentLabel() {
        commentTextLabel.anchor(top: horizontalStackView.bottomAnchor, bottom: verticalStackView.bottomAnchor, leading: verticalStackView.leadingAnchor, trailing: verticalStackView.trailingAnchor, paddingTop: 0, paddingBottom: -commentTextField.frame.height / 2.1, paddingLeft: 16, paddingRight: 16)
        commentTextLabel.isHidden = true
    }
    
    //MARK: - VIEWS
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        return titleLabel
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        
        button.backgroundColor = .clear
        button.tintColor = .orange
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.sizeToFit()
        
        return button
    }()
    
    let commentButton2: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        
        button.backgroundColor = .clear
        button.tintColor = .orange
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.sizeToFit()
        button.isHidden = true
        
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
        ctf.layer.cornerRadius = 5
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
    
    let commentTextLabel: UILabel = {
        let ctl = UILabel()
        ctl.backgroundColor = .clear
        ctl.textColor = .systemRed
        ctl.textAlignment = .left
        ctl.numberOfLines = 0
        
        return ctl
    }()
}

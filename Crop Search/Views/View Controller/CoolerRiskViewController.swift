//
//  NewMainViewController.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 8/26/21.
//

import UIKit

class CoolerRiskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cells: [String] = [Strings.cellOne, Strings.cellTwo, Strings.cellThree, Strings.cellFour, Strings.cellFive]
    var expandedCells: [Int] = []
    var selectedSC: [Int] = []
    var safeArea: UILayoutGuide {
        self.view.safeAreaLayoutGuide
    }
    let custom = CoolerRiskTableViewCell()
    
    //MARK: - VIEWS
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoolerRiskTableViewCell.self, forCellReuseIdentifier: CoolerRiskTableViewCell.identifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle(Strings.saveButton, for: .normal)
        saveButton.setTitleColor(.orange, for: .normal)
        saveButton.sizeToFit()
        saveButton.contentVerticalAlignment = .center
        saveButton.contentHorizontalAlignment = .center
        
        return saveButton
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.setTitle(Strings.submitButton, for: .normal)
        submitButton.setTitleColor(.orange, for: .normal)
        
        return submitButton
    }()
    
    private let saveSubmitStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.backgroundColor = .systemBackground
        
        return sv
    }()
    
    private let line: UIView = {
       let line = UIView()
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.black.cgColor
        line.layer.opacity = 0.1
        
        return line
    }()
    
    private let line2: UIView = {
       let line = UIView()
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.black.cgColor
        line.layer.opacity = 0.1
        
        return line
    }()
    
    private let dashboardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Strings.dashboardButtonImage), for: .normal)
        button.setTitle(Strings.dashboardButtonTitle, for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.tintColor = .lightGray
        button.sizeToFit()
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.sizeToFit()
        button.titleLabel?.font = UIFont(name: Strings.avenirRomanFont, size: 15)
        
        return button
    }()
    
    private let foodSafetyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Strings.foodSafetyButtonImage), for: .normal)
        button.setTitle(Strings.foodSafetyButtonTitle, for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.tintColor = .orange
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.sizeToFit()
        button.titleLabel?.font = UIFont(name: Strings.avenirRomanFont, size: 15)
        
        return button
    }()
    
    private let dashboardFoodStackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        
        return sv
    }()
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addAllSubviews()
        setupSaveSubmitSV()
        setupDashboardFoodSV()
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .orange
        title = Strings.CoolerFacilityRiskAsssessmentTitle
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        
        saveSubmitStackView.anchor(top: tableView.bottomAnchor, bottom: dashboardFoodStackView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, height: 50)
        
        saveButton.anchor(top: saveSubmitStackView.topAnchor, bottom: saveSubmitStackView.bottomAnchor, leading: saveSubmitStackView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: view.frame.width / 3, paddingRight: 0, width: saveButton.frame.width, height: saveButton.frame.height)
        
        submitButton.anchor(top: saveSubmitStackView.topAnchor, bottom: saveSubmitStackView.bottomAnchor, leading: nil, trailing: saveSubmitStackView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: view.frame.width / 3)
        
        dashboardFoodStackView.anchor(top: saveSubmitStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, height: 50)
        
        dashboardButton.anchor(top: dashboardFoodStackView.topAnchor, bottom: dashboardFoodStackView.bottomAnchor, leading: dashboardFoodStackView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: view.frame.width / 3, paddingRight: 0, width: dashboardButton.frame.width, height: dashboardButton.frame.height)
        
        foodSafetyButton.anchor(top: dashboardFoodStackView.topAnchor, bottom: dashboardFoodStackView.bottomAnchor, leading: nil, trailing: dashboardFoodStackView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: view.frame.width / 3, width: foodSafetyButton.frame.width, height: foodSafetyButton.frame.height)

        
        line.frame = CGRect(x: 0, y: 0, width: saveSubmitStackView.frame.width, height: 1)
        line2.frame = CGRect(x: 0, y: 0, width: dashboardFoodStackView.frame.width, height: 1)

    }
    
    //MARK: - FUNCTIONS
    func addAllSubviews() {
        view.addSubview(tableView)
        view.addSubview(saveSubmitStackView)
        view.addSubview(saveButton)
        view.addSubview(submitButton)
        view.addSubview(saveSubmitStackView)
        view.addSubview(dashboardFoodStackView)
        view.addSubview(dashboardButton)
        view.addSubview(foodSafetyButton)
    }
    
    func setupSaveSubmitSV() {
        saveSubmitStackView.addSubview(saveButton)
        saveSubmitStackView.addSubview(submitButton)
        saveSubmitStackView.addSubview(line)
    }
    
    func setupDashboardFoodSV() {
        dashboardFoodStackView.addSubview(dashboardButton)
        dashboardFoodStackView.addSubview(foodSafetyButton)
        dashboardFoodStackView.addSubview(line2)
    }
    
    @objc func saveButtonTapped() {
        showCommentTextLabel(cell: custom)
    }
    
}//End of class

extension CoolerRiskViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        let selected = Array(Set(selectedSC))
        
        if cells.count == selected.count {
            view.backgroundColor = .green
        } else {
            view.backgroundColor = .gray
        }
        
        label.text = Strings.sectionOne
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.clipsToBounds = true
        label.frame = CGRect(x: 16, y: view.frame.height / 2, width: tableView.frame.width - 16, height: 50)
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoolerRiskTableViewCell.identifier, for: indexPath) as? CoolerRiskTableViewCell else {return UITableViewCell()}
        
        let cells = cells[indexPath.row]
        cell.setTitle(title: cells)
        cell.delegate = self
        cell.selectionStyle = .none
        cell.tag = indexPath.row

        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if ((indexPath.row % 2) != 0) {
            cell.backgroundColor = .secondarySystemFill
        } else {
            cell.backgroundColor = .systemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedCells.contains(indexPath.row) {
            return 100
        } else {
            return 50
        }
    }
    

    
}//End of class

extension CoolerRiskViewController: cellUpdate {
    func showCommentTextLabel(cell: CoolerRiskTableViewCell) {
        cell.commentTextField.isHidden = true
        cell.commentTextLabel.isHidden = false
        tableView.reloadData()
    }
    
    func getSC(cell: CoolerRiskTableViewCell) {
        selectedSC.append(cell.tag)
        tableView.reloadData()
    }
    
    func updateTableView(cell: CoolerRiskTableViewCell) {
        cell.commentTextField.isHidden.toggle()
        cell.commentButton2.isHidden.toggle()
        cell.commentButton.isHidden.toggle()
        
        if expandedCells.contains(cell.tag) {
            expandedCells = expandedCells.filter({ $0 != cell.tag})
        } else {
            expandedCells.append(cell.tag)
        }
        
        tableView.reloadData()
    }
}//End of extension

//
//  NewMainViewController.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 8/26/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cells: [String] = [Strings.cellOne, Strings.cellTwo, Strings.cellThree, Strings.cellFour, Strings.cellFive]
    var expandedCells: [Int] = []
    var selectedSC: [Int] = []
    var indexSegment: [Int] = []
    var safeArea: UILayoutGuide {
        self.view.safeAreaLayoutGuide
    }
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save Changes", for: .normal)
        saveButton.setTitleColor(.orange, for: .normal)
        saveButton.sizeToFit()
        saveButton.contentVerticalAlignment = .center
        saveButton.contentHorizontalAlignment = .center
        
        return saveButton
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton()
        
        submitButton.setTitle("Final Submit", for: .normal)
        submitButton.setTitleColor(.orange, for: .normal)
        
        return submitButton
    }()
    
    private let saveSubmitStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.backgroundColor = .systemBackground
        
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addAllSubviews()
        setupSaveSubmitSV()
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Strings.title
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        
        saveSubmitStackView.anchor(top: tableView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, height: 50)
        
        saveButton.anchor(top: saveSubmitStackView.topAnchor, bottom: saveSubmitStackView.bottomAnchor, leading: saveSubmitStackView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: view.frame.width / 3, paddingRight: 0, width: saveButton.frame.width, height: saveButton.frame.height)
        
        submitButton.anchor(top: saveSubmitStackView.topAnchor, bottom: saveSubmitStackView.bottomAnchor, leading: nil, trailing: saveSubmitStackView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: view.frame.width / 3)
    }
    
    //MARK: - FUNCTIONS
    func addAllSubviews() {
        view.addSubview(tableView)
        view.addSubview(saveSubmitStackView)
        view.addSubview(saveButton)
        view.addSubview(submitButton)
        view.addSubview(saveSubmitStackView)
    }
    
    func setupSaveSubmitSV() {
        saveSubmitStackView.addSubview(saveButton)
        saveSubmitStackView.addSubview(submitButton)
    }
    
    @objc func saveButtonTapped() {
        
    }
    
    
}//End of class

extension MainViewController {
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
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

extension MainViewController: cellUpdate {
    func getSC(cell: CustomTableViewCell) {
        selectedSC.append(cell.tag)
        tableView.reloadData()
    }
    
    func updateTableView(cell: CustomTableViewCell) {
        cell.commentTextField.isHidden.toggle()
        if expandedCells.contains(cell.tag) {
            expandedCells = expandedCells.filter({ $0 != cell.tag})
        } else {
            expandedCells.append(cell.tag)
        }
        print(expandedCells)
        tableView.reloadData()
    }
    
    
}//End of extension

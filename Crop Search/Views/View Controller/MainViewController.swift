//
//  NewMainViewController.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 8/26/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cells: [String] = [Strings.cellOne, Strings.cellTwo, Strings.cellThree, Strings.cellFour, Strings.cellFive]
    static var selectedIndex: NSInteger! = -1
    var buttonTag: Int?
    var checked = Set<IndexPath>()
    var expandedCells: [Int] = []

    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Strings.title
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
}//End of class

extension MainViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        
        if cells.count == CustomTableViewCell.allSelected / 2 {
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
//        MainViewController.indexOfButton.append(buttonTag ?? -1)
//        print(MainViewController.indexOfButton)
//        CustomTableViewCell.commentTextField.isHidden = self.checked.contains(indexPath)
        
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

}

extension MainViewController: cellUpdate {
    func updateTableView(cell: CustomTableViewCell) {
        cell.commentTextField.isHidden.toggle()
        if expandedCells.contains(cell.tag) {
            expandedCells = expandedCells.filter({ $0 != cell.tag})
        } else {
            expandedCells.append(cell.tag)
        }
        tableView.reloadData()
    }
}


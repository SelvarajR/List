//
//  ViewController.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView.init(frame: UIScreen.main.bounds)
    private let constant = Constants()
    lazy var viewModel = {
            ListViewModel()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initViewModel()
    }
    
    func initView() {
        navigationItem.title = "List"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        view.addSubview(tableView)
    }
    
    func initViewModel() {
        viewModel.delegate = self as ModelDelegate
        viewModel.getLists()
    }

}

extension ViewController: ModelDelegate {

    /* Service call ends and populating the data on TableView  */
    func didReceiveData(callback: String) {
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: ListCell = tableView.dequeueReusableCell(withIdentifier:
                                                                    "ListCell", for: indexPath) as? ListCell else {
            fatalError("Cell does not exists")
        }
        
        let row = viewModel.tableRows[indexPath.row]
        cell.title.text = row.title
        cell.descriptionText.text = row.description
        return cell
    }
    
}

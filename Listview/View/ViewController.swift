//
//  ViewController.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initViewModel()
    }
    
    func initView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: constant.cellIdentifer)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        refresher.attributedTitle = NSAttributedString(string: constant.refresher)
        refresher.addTarget(self, action: #selector(initViewModel), for: .valueChanged)
        tableView.addSubview(refresher)
    }
    
    @objc func initViewModel() {
        
        viewModel.getLists()
        viewModel.reloadTableView = { [weak self] in
                    DispatchQueue.main.async {
                        self?.navigationItem.title = self?.viewModel.tableTitle
                        self?.refresher.endRefreshing()
                        self?.tableView.reloadData()
                    }
                }
    }
    
    private let tableView = UITableView.init(frame: UIScreen.main.bounds)
    private let refresher = UIRefreshControl()
    private let constant = Constants()
    lazy var viewModel = {
            ListViewModel()
        }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier:
                                                            constant.cellIdentifer, for: indexPath) as! ListCell
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
    
}

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
        initView()
        initViewModel()
    }
    
    /* initialize the View UI elements */
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: constant.cellIdentifer)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        refresher.attributedTitle = NSAttributedString(string: constant.refresher)
        refresher.addTarget(self, action: #selector(initViewModel), for: .valueChanged)
        tableView.addSubview(refresher)
    }
    
    /* initialize the request to fetch data */
    @objc private func initViewModel() {
        viewModel.getLists()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationItem.title = self?.viewModel.tableTitle
                self?.refresher.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
    
    private let tableView = UITableView(frame: UIScreen.main.bounds)
    private let refresher = UIRefreshControl()
    private let constant = Constants()
    lazy var viewModel = {
        ListViewModel()
    }()
}

/* Table delegate and data sources declarations */
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listCellViewModels.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ListCell = tableView.dequeueReusableCell(
            withIdentifier: constant.cellIdentifer, for: indexPath
        ) as? ListCell else {
            fatalError(constant.fatalErrorMessageForCell)
        }
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}

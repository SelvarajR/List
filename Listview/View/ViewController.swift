//
//  ViewController.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit
import Kingfisher
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
        refresher.addTarget(self, action: #selector(reloadData(sender:)), for: .valueChanged)
        tableView.addSubview(refresher)
    }
    
    func initViewModel() {
        viewModel.delegate = self as ModelDelegate
        viewModel.getLists()
    }
    
    private let tableView = UITableView.init(frame: UIScreen.main.bounds)
    private let refresher = UIRefreshControl()
    private let constant = Constants()
    lazy var viewModel = {
            ListViewModel()
        }()
}

extension ViewController: ModelDelegate {

    /* Service call ends and populating the data on TableView  */
    func didReceiveData(response: HTTPResponse) {
        refresher.endRefreshing()
        
        switch response {
            case .success:
                navigationItem.title = viewModel.tableTitle
                tableView.reloadData()
            case .error:
                showAlert(constant.error)
            case .noInternet:
                showAlert(constant.noInternet)
        }
        
    }
    
    func showAlert(_ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: constant.ok, style: .default, handler: { _ in
                }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /* Fetching data over the network upon pull down the Table */
    @objc func reloadData(sender: AnyObject) {
        
        viewModel.getLists()
    }
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
        let row = viewModel.tableRows[indexPath.row]
        cell.title.text = row.title
        cell.descriptionText.text = row.description
        cell.avatar.kf.setImage(with: URL(string: row.image ?? ""), placeholder: UIImage(named: constant.placeHolderImage))
        return cell
    }
    
}

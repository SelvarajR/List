//
//  ViewController.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit

class ViewController: UIViewController {

    private let tableView = UITableView.init(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "List"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        view.addSubview(tableView)
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier:
                                                            "ListCell", for: indexPath) as! ListCell
        cell.title.text = "Test Title"
        cell.descriptionText.text = "Test description here.."
        return cell
    }
    
}

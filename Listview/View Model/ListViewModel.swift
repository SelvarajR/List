//
//  ListViewModel.swift
//  Listview
//
//  Created by Selvaraj R on 19/11/21.
//

import Foundation

/* Dalegate method to return the data to callback */
protocol ModelDelegate: AnyObject {
    func didReceiveData(callback: String)
}

class ListViewModel: NSObject {
    private var listService: ListServiceProtocol

    init(listService: ListServiceProtocol = ListService()) {
        self.listService = listService
    }

    func getLists() {
        listService.getLists { success, data, error in
            if success, let detailsDict = data as? NSDictionary {
                                
                self.setData(data: detailsDict)

            } else {
                print("Error")
            }
        }
    }
    
    /* Data setup from the received data */
    func setData(data: NSDictionary) {
        let demo = ListModel.from(data as NSDictionary)
        tableTitle = demo?.demoTitle ?? ""
        tableRows = demo?.demoTableRows ?? []
        self.delegate?.didReceiveData(callback: "success") /* Callback */
    }
        
    var tableTitle: String?
    var tableRows = [DataMapping]()
    private let constant = Constants()
    weak var delegate: ModelDelegate?
}
    

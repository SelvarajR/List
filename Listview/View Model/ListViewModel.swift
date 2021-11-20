//
//  ListViewModel.swift
//  Listview
//
//  Created by Selvaraj R on 19/11/21.
//

import Foundation

/* Dalegate method to return the data to callback */
protocol ModelDelegate: AnyObject {
    func didReceiveData(response: HTTPResponse)
}

class ListViewModel: NSObject {
    private var listService: ListServiceProtocol

    init(listService: ListServiceProtocol = ListService()) {
        self.listService = listService
    }

    func getLists() {
        if Reachability().isInternetAvailable {
            listService.getLists { success, data, error in
                if success, let detailsDict = data as? NSDictionary {
                                    
                    self.setData(data: detailsDict)

                } else {
                    self.delegate?.didReceiveData(response: .error) /* Callback */
                }
            }
        } else {
            self.delegate?.didReceiveData(response: .noInternet) /* Callback */
        }
        
    }
    
    /* Data setup from the received data */
    func setData(data: NSDictionary) {
        let demo = ListModel.from(data as NSDictionary)
        tableTitle = demo?.demoTitle ?? ""
        tableRows = demo?.demoTableRows ?? []
        self.delegate?.didReceiveData(response: .success) /* Callback */
    }
        
    var tableTitle: String?
    var tableRows = [DataMapping]()
    private let constant = Constants()
    weak var delegate: ModelDelegate?
}
    

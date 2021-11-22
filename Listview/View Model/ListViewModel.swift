//
//  ListViewModel.swift
//  Listview
//
//  Created by Selvaraj R on 19/11/21.
//

import Foundation
import UIKit

class ListViewModel: NSObject {
    
    init(listService: ListServiceProtocol = ListService()) {
        self.listService = listService
    }

    /* GetLists API request begins */
    func getLists() {
        if Reachability().isInternetAvailable {
            listService.getLists { success, data, error in
                if success, let detailsDict = data as? NSDictionary {
                    /* receive API response as Dictionalry*/
                    self.setData(data: detailsDict)
                }
                else {
                    self.showAlert(self.constant.error)
                }
            }
        }
        else {
            self.showAlert(constant.noInternet)
        }
    }
    
    /* cell view model data bindings */
    func getCellViewModel(at indexPath: IndexPath) -> ListCellViewModel {
        listCellViewModels[indexPath.row]
    }
    
    private let constant = Constants()
    private var listService: ListServiceProtocol
    var listCellViewModels = [ListCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var tableTitle: String?
    var tableRows = [DataMapping]()
    var reloadTableView: (() -> Void)?
}
    
extension ListViewModel {
    
    /* Data setup from the received data */
    func setData(data: NSDictionary) {
        let demo = ListModel.from(data as NSDictionary)
        tableTitle = demo?.demoTitle ?? ""
        tableRows = demo?.demoTableRows ?? []
        appendData(rows: tableRows)
    }
    
    func appendData(rows: [DataMapping]) {
        var vms = [ListCellViewModel]()
        for row in tableRows {
            if row.title != nil || row.description != nil || row.image != nil {
                vms.append(createCellModel(list: row))
            }
        }
        listCellViewModels = vms
    }
    
    func createCellModel(list: DataMapping) -> ListCellViewModel {
        ListCellViewModel(
            cellTitle: list.title ?? "",
            cellDesc: list.description ?? "",
            cellImag: list.image ?? ""
        )
    }
    
    /* Show Alert: when no internet or any error while fetching the data */
    func showAlert(_ message: String) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let alert = UIAlertController(title: constant.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: constant.ok, style: .default, handler: { _ in
                        })
        )
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

struct ListCellViewModel {
    var cellTitle: String
    var cellDesc: String
    var cellImag: String
}

//
//  ListViewModel.swift
//  Listview
//
//  Created by Selvaraj R on 19/11/21.
//

import Foundation
import UIKit

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
                    self.showAlert(self.constant.error)
                }
            }
        } else {
            self.showAlert(constant.noInternet)
        }
    }
    
    /* Data setup from the received data */
    func setData(data: NSDictionary) {
        let demo = ListModel.from(data as NSDictionary)
        tableTitle = demo?.demoTitle ?? ""
        tableRows = demo?.demoTableRows ?? []
        
        var vms = [ListCellViewModel]()
                for row in tableRows {
                    vms.append(createCellModel(list: row))
                }
                listCellViewModels = vms
    }
        
    func createCellModel(list: DataMapping) -> ListCellViewModel {
        return ListCellViewModel(
            cellTitle: list.title ?? "",
            cellDesc: list.description ?? "",
            cellImag: list.image ?? ""
        )
        }
    
    func getCellViewModel(at indexPath: IndexPath) -> ListCellViewModel {
            return listCellViewModels[indexPath.row]
        }
    
    /* Show Alert: when no internet or any error while fetching the data */
    func showAlert(_ message: String) {
        
        let alert = UIAlertController(title: constant.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: constant.ok, style: .default, handler: { _ in
                        }))
        let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        rootViewController?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    private let constant = Constants()
    var tableTitle: String?
    var tableRows = [DataMapping]()
    var reloadTableView: (() -> Void)?
    var listCellViewModels = [ListCellViewModel]() {
            didSet {
                reloadTableView?()
            }
        }
}
    
struct ListCellViewModel {
    var cellTitle: String
    var cellDesc: String
    var cellImag: String
}

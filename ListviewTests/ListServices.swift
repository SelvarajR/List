//
//  ListServices.swift
//  ListviewTests
//
//  Created by Selvaraj R on 22/11/21.
//

import XCTest
@testable import Listview

class ListServices: XCTestCase {

    var datasource = ListViewModel()
    var service = ListService()

    func testListServiceCall() {
        let expectation = XCTestExpectation(description: "Data")
        service.getLists(completion: { _, _, error in
            if error != nil {
                XCTFail("Fail")
            }
            expectation.fulfill()
            
            self.waitForExpectations(timeout: 2, handler: nil)
        })
    }
    
    func testGetListMethodToAppendData() {
        datasource.appendData(rows: datasource.tableRows)
        for row in datasource.tableRows {
            XCTAssertNotNil(datasource.createCellModel(list: row))
        }
        XCTAssertNotNil(datasource.listCellViewModels)
    }
}

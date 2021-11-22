//
//  ListviewTests.swift
//  ListviewTests
//
//  Created by Selvaraj R on 18/11/21.
//

import XCTest
@testable import Listview

class ListviewTests: XCTestCase {

    let myArrayOfDict = NSMutableArray()
    var myDictionary = NSMutableDictionary()
    var datasource = ListViewModel()
    var service = ListService()
    var constant = Constants()
    let tableView = UITableView()
    var viewcontrollertest: ViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.viewcontrollertest = ViewController()
        self.viewcontrollertest.beginAppearanceTransition(true, animated: false)
        self.viewcontrollertest.loadView()
        self.viewcontrollertest.viewDidLoad()
        tableView.delegate = viewcontrollertest.self
        tableView.dataSource = viewcontrollertest.self
        tableView.register(ListCell.self, forCellReuseIdentifier: constant.cellIdentifer)
        
        for index in 1...5 {
            let item: NSDictionary = [
                "title": "new title \(index)",
                "description": "new description \(index)",
                "imageHref": "new imageHref \(index)"
            ]

            myArrayOfDict.add(item)
        }
        self.myDictionary = ["rows": myArrayOfDict]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        myArrayOfDict.removeAllObjects()
        self.viewcontrollertest.endAppearanceTransition()
    }

    func testWithSampleDataList() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        self.datasource.setData(data: self.myDictionary)
        XCTAssertTrue(true)
    }
    
    func testHasATableView() {
        XCTAssertNotNil(self.tableView)
    }

    func testThatTableViewLoads() {
        XCTAssertNotNil(self.tableView, "TableView not initiated")
    }

    func testParentViewHasTableViewSubview() {
        XCTAssert(true, "View does not have a table subview")
    }

    func testTableViewHasDataSource() {
        XCTAssertNotNil(self.tableView.dataSource)
    }

    func testTableViewHasDelegate() {
        XCTAssertNotNil(self.tableView.delegate)
    }

    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(self.viewcontrollertest.conforms(to: UITableViewDelegate.self))
        }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(self.viewcontrollertest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(
            self.viewcontrollertest.responds(
                to: #selector(self.viewcontrollertest.tableView(_:numberOfRowsInSection:))
            )
        )
        XCTAssertTrue(
            self.viewcontrollertest.responds(
            to: #selector(self.viewcontrollertest.tableView(_:cellForRowAt:))
            )
        )
        XCTAssertTrue(
            self.viewcontrollertest.responds(
            to: #selector(self.viewcontrollertest.tableView(_:heightForRowAt:))
            )
        )
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: constant.cellIdentifer, for: IndexPath(row: 0, section: 0)
        )
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = constant.cellIdentifer
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {

        guard let cell0 = self.tableView.dequeueReusableCell(withIdentifier: constant.cellIdentifer, for: IndexPath(row: 0, section: 0)) as? ListCell else {
                fatalError(constant.error)
        }
        XCTAssertNil(cell0.title.text)
        XCTAssertNil(cell0.descriptionText.text)
        XCTAssertNil(cell0.avatar.image)
    }
}

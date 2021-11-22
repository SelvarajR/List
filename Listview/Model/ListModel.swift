//
//  ListModel.swift
//  Listview
//
//  Created by Selvaraj R on 19/11/21.
//

import Foundation
import Mapper

/* ListModel to parse the title and rows from JSON */
struct ListModel: Mappable {

    /* Variable declaration and updating */
    let demoItems: NSArray?
    var demoTitle: String?
    var demoTableRows = [DataMapping]()

    init(map: Mapper) throws {
        try demoTitle = map.from("title")
        try demoItems = map.from("rows")
        
        let demoArray = demoItems ?? []
        for row in demoArray {
            if let row = DataMapping.from((row as? NSDictionary)!) {
                demoTableRows.append(row)
            }
        }
    }
}

/* DataMapping to parse the table rows from JSON */
struct DataMapping: Mappable {

    var title: String? = ""
    var description: String? = ""
    var image: String? = ""

    init(map: Mapper) throws {
        title = try? map.from("title")
        description = try? map.from("description")
        image = try? map.from("imageHref")
    }
}

//
//  Reachability.swift
//  Listview
//
//  Created by Selvaraj R on 20/11/21.
//

import Alamofire

struct Reachability {
    /* Check the internet connection availability */
    var isInternetAvailable: Bool {
        NetworkReachabilityManager()!.isReachable
    }
}

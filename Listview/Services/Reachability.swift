//
//  Reachability.swift
//  Listview
//
//  Created by Selvaraj R on 20/11/21.
//

import Alamofire

struct Reachability {

    var isInternetAvailable:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

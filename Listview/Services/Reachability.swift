//
//  Reachability.swift
//  Listview
//
//  Created by Selvaraj R on 20/11/21.
//

import Alamofire

enum HTTPResponse {
    case success
    case error
    case noInternet
}

struct Reachability {

    var isInternetAvailable:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

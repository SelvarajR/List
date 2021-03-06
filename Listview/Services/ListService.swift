//
//  ListService.swift
//  Listview
//
//  Created by Selvaraj R on 19/11/21.
//

import Foundation
import Alamofire

protocol ListServiceProtocol {
    func getLists(completion: @escaping (_ success: Bool, _ results: Any, _ error: String?) -> Void)
}

class ListService: ListServiceProtocol {
    
    func getLists(completion: @escaping (Bool, Any, String?) -> Void) {
        /* API service calls through Alamofire lib */
        AF.request(constant.url, method: .get, encoding: JSONEncoding.default).response { response in
            let responseStrInISOLatin = String(data: response.data ?? Data(), encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                return
            }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: .mutableContainers)
                completion(true, parsedData, nil)
            }
            catch {
                completion(false, [], self.constant.fatalErrorMessageOnCompletion)
            }
        }
    }
    
    private let constant = Constants()
}

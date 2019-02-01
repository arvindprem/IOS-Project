//
//  SessionHandler.swift
//  COLOR
//
//  Created by Arvind Prem on 01/02/19.
//  Copyright © 2019 Arvind. All rights reserved.
//

import Foundation
class SessionHandler {
    static let shared = SessionHandler()
    
    //Generic function for GET request and JSON parsing
    func fetchFromApi<T: Decodable>(url: URL, completion: @escaping (T) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                //Swift 4's new feature(DECODABLE) to parse JSON
                let user = try JSONDecoder().decode(T.self, from: data)
                completion(user)
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }
}

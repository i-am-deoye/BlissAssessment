//
//  HTTPClient.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    
    func get(from url: URL, completion: @escaping (Result) -> Void )
}

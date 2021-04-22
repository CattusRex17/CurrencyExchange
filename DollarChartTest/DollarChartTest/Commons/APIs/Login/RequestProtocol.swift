//
//  RequestProtocol.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation

protocol RequestProtocol {
    
    func isServerAlive() -> Bool
    
    func getUser(email: String, password: String, result: @escaping (Int, String) -> ())
}

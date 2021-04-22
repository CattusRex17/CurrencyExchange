//
//  MockLogin.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation
import UIKit

class MockLogin: RequestProtocol {
    
    static let shared = MockLogin()
    
    private init(){}
    
    func isServerAlive() -> Bool {
        return true
    }
    
    func getUser(email: String, password: String, result: @escaping (Int, String) -> ()) {
        if email == "userTest@gmail.com" && password == "P@$$w0rD!" {
            result (200, "Usuario Correcto")
        } else {
            result (404, "Usuario Incorrecto")
        }
        return
    }
}


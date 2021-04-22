//
//  LoginEntity.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation

struct RequestLogin {
    let email: String
    let password: String
}

struct ResponseLogin {
    let status: Int
    let message: String
}


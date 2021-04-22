//
//  ChartEntity.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation

// MARK: - Countries
struct ResponseChart: Codable {
    let usdMxn, eurMxn: [String: Double]

    enum CodingKeys: String, CodingKey {
        case usdMxn = "USD_MXN"
        case eurMxn = "EUR_MXN"
    }
}

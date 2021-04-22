//
//  Networkable.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation
import Moya

// Alias used in service imlpementation
typealias ChartAlias = (ResponseChart) -> Void

//// Protocol used for implementation services with Moya
protocol Networkable {
    var provider: MoyaProvider<ChartAPI> { get }
    func getChart(date: String, endDate: String, completion: @escaping ChartAlias)
}

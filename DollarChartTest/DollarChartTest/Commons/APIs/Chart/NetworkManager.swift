//
//  NetworkManager.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation
import Moya
import Alamofire

/**
Structure with service configuration and implementation: Historical Price
*/
struct NetworkManager: Networkable {
    
    var provider = MoyaProvider<ChartAPI>()
/**
Structure with service configuration and implementation: Historical Price
     - parameters:
        - date: initial date
        - endDate: final date
        - completion: ChartAlias
*/
    func getChart(date: String, endDate: String, completion: @escaping ChartAlias) {
        provider.request(.chart(date: date, endDate: endDate)) { (result) in
            print(result)
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(ResponseChart.self, from: response.data)
                    completion(results)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                if let reachabilityManger = NetworkReachabilityManager() {
                    if !reachabilityManger.isReachable {
                        print("offline")
                    }
                }
                print(error.localizedDescription)
            }
        }
    }
}

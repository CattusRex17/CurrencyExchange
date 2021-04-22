//
//  ApiChart.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation
import Moya
import Alamofire

enum ChartAPI {
    /**
    Communication interface for Chart  Service
    */
    case chart(date: String, endDate: String)
}

extension ChartAPI: TargetType {
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: URL {
        return URL(string: "https://free.currconv.com/api/v7/convert")!
    }
    
    var path: String {
        switch self {
        case .chart:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }

    var task: Task {
        switch self {
        case .chart(let date, let dateEnd):
            return .requestParameters(parameters: ["apiKey": "7205e037ac1b594fd74e", "q": "USD_MXN,EUR_MXN", "compact": "ultra", "date": date, "endDate": dateEnd], encoding: self.encoding)
        }
    }
}

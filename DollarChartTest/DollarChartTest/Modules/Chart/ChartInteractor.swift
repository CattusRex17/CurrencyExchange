//
//  ChartInteractor.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

class ChartInteractor: ChartInteractorProtocol {

    weak var presenter: ChartOutputInteractorProtocol?
    let networkManager = NetworkManager()

    func getChart(from view: UIViewController, date: String, endDate: String) {
        networkManager.getChart(date: date, endDate: endDate) { (chart) in
            self.presenter?.receiveChart(data: chart)
        }
    }
}

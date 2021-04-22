//
//  ChartPresenter.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

class ChartPresenter: ChartPresenterProtocol {
    func getDataChart(date: String, endDate: String) {
        interactor?.getChart(from: view as! UIViewController, date: date, endDate: endDate)
    }

    var router: ChartRouterProtocol?
    var view: ChartViewProtocol?
    var interactor: ChartInteractorProtocol?
    var presenter: ChartPresenterProtocol?
}

extension ChartPresenter: ChartOutputInteractorProtocol {
    func receiveChart(data: ResponseChart) {
        view?.returnChart(data: data)
    }
}

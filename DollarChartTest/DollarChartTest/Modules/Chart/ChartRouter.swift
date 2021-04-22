//
//  ChartRouter.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

class ChartRouter: ChartRouterProtocol {
    class func createModule(chartRef: ChartView) {
        let presenter: ChartPresenterProtocol & ChartOutputInteractorProtocol = ChartPresenter()
        chartRef.presenter = presenter
        chartRef.presenter?.router = ChartRouter()
        chartRef.presenter?.view = chartRef
        chartRef.presenter?.interactor = ChartInteractor()
        chartRef.presenter?.interactor?.presenter = presenter
    }
}

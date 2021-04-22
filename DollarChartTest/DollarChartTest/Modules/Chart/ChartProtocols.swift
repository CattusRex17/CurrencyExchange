//
//  ChartProtocols.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

protocol ChartViewProtocol: class {
    // PRESENTER -> VIEW
    func returnChart(data: ResponseChart)
}

protocol ChartPresenterProtocol: class {
    //View -> Presenter
    var interactor: ChartInteractorProtocol? {get set}
    var view: ChartViewProtocol? {get set}
    var router: ChartRouterProtocol? {get set}

    func getDataChart(date: String, endDate: String)
}

protocol ChartInteractorProtocol: class {
    var presenter: ChartOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func getChart(from view: UIViewController, date: String, endDate: String)
}

protocol ChartOutputInteractorProtocol: class {
//    Interactor -> PresenterOutput
    func receiveChart(data: ResponseChart)
}

protocol ChartRouterProtocol: class {
    //Presenter -> Wireframe
    static func createModule(chartRef: ChartView)
}

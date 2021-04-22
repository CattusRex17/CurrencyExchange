//
//  LoginProtocols.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

protocol LoginViewProtocol: class {
    // PRESENTER -> VIEW
    func errorLogin(detail: ResponseLogin)
}

protocol LoginPresenterProtocol: class {
    //View -> Presenter
    var interactor: LoginInteractorProtocol? {get set}
    var view: LoginViewProtocol? {get set}
    var router: LoginRouterProtocol? {get set}

    func getDataLogin(email: String, password: String)
    func goToCountries()
}

protocol LoginInteractorProtocol: class {
    var presenter: LoginOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func getDetailLogin(from view: UIViewController, data: RequestLogin)
}

protocol LoginOutputInteractorProtocol: class {
//    Interactor -> PresenterOutput
    func receiveDetail(detail: ResponseLogin)
}

protocol LoginRouterProtocol: class {
    //Presenter -> Wireframe
    static func createModule(loginRef: LoginView)
    func pushToCountries(from view: UIViewController)
}

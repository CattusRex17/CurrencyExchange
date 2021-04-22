//
//  LoginPresenter.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {

    var router: LoginRouterProtocol?
    var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var presenter: LoginPresenterProtocol?

    func getDataLogin(email: String, password: String) {
        let data = RequestLogin(email: email, password: password)
        interactor?.getDetailLogin(from: view as! UIViewController, data: data)
    }
    
    func goToCountries() {
        router?.pushToCountries(from: view as! UIViewController)
    }
}

extension LoginPresenter: LoginOutputInteractorProtocol {
    func receiveDetail(detail: ResponseLogin) {
        if detail.status == 200 {
            goToCountries()
        } else {
            view?.errorLogin(detail: detail)
        }
    }
}

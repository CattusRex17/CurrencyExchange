//
//  LoginInteractor.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

class LoginInteractor: LoginInteractorProtocol {

    weak var presenter: LoginOutputInteractorProtocol?
    let apiManager = MockLogin.shared
    
    func getDetailLogin(from view: UIViewController, data: RequestLogin) {
        let isAlive = apiManager.isServerAlive()
        let randomDouble = Double.random(in: 0.2...2.0)
        if isAlive {
            DispatchQueue.main.asyncAfter(deadline: .now() + randomDouble) {
                self.apiManager.getUser(email: data.email, password: data.password) { (status, msg) in
                    self.presenter?.receiveDetail(detail: ResponseLogin.init(status: status, message: msg))
                }
            }
        } else {
            self.presenter?.receiveDetail(detail: ResponseLogin.init(status: 400, message: "No se logró establecer conexión con el servidor, intentelo más tarde"))
        }
    }
}

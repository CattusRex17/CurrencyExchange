//
//  LoginRouter.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit

class LoginRouter: LoginRouterProtocol {

    func pushToCountries(from view: UIViewController) {
        let storyboard = UIStoryboard(name: "Chart", bundle: nil)
        let countriesViewController = storyboard.instantiateViewController(withIdentifier: "ChartView") as! ChartView
        view.navigationController?.pushViewController(countriesViewController, animated: true)
    }

    class func createModule(loginRef: LoginView) {
        let presenter: LoginPresenterProtocol & LoginOutputInteractorProtocol = LoginPresenter()
        loginRef.presenter = presenter
        loginRef.presenter?.router = LoginRouter()
        loginRef.presenter?.view = loginRef
        loginRef.presenter?.interactor = LoginInteractor()
        loginRef.presenter?.interactor?.presenter = presenter
    }
}

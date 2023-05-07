//
//  LoginVC.swift
//  PopDemo
//
//  Created by Ale on 05/12/2021.
//

import UIKit
import RxSwift

class LoginVC: UIViewController {

    //MARK: - Properties
    private let tag = "LoginVC"
    private let disposeBag = DisposeBag()
    private let viewModel = LoginVM()
    
    private var canMoveToDashboard: Bool = false
    
    //MARK: - IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

//MARK: - Custom Methods
extension LoginVC{
    
    fileprivate func setupBindings(){
        tfEmail.rx.text.map {$0 ?? "" }.bind(to: viewModel.emailPS).disposed(by: disposeBag)
        tfPassword.rx.text.map {$0 ?? "" }.bind(to: viewModel.passwordPS).disposed(by: disposeBag)
        
//        viewModel.isValid().bind(to: btnLogin.rx.isEnabled).disposed(by: disposeBag)
        
        
        viewModel.canMoveToDashboard().asObservable().subscribe { [weak self] status in
            if status{
                self?.canMoveToDashboard = true
            }else{
                print("Wrong Credentials")
            }
        } onError: { [weak self] error in
            print("Tag: \(self?.tag ?? "")")
        }.disposed(by: disposeBag)
        
        self.buttonActions()
    }
    
    fileprivate func buttonActions(){
        btnLogin.rx
            .tap.bind{ [weak self] in
                if self?.canMoveToDashboard ?? false{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC")
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }.disposed(by: disposeBag)
    }
}
}

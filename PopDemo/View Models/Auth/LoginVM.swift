//
//  LoginVM.swift
//  PopDemo
//
//  Created by Ale on 05/12/2021.
//

import RxSwift
import RxCocoa
import Foundation

class LoginVM{
    
    //MARK: - Properties
    let emailPS = PublishSubject<String>()
    let passwordPS = PublishSubject<String>()
    
    //MARK: - Custom Methods
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailPS.asObserver().startWith(""), passwordPS.asObservable().startWith("")).map { email, password in
            return email.count > 0 && password.count > 0
        }.startWith(false)
    }
    
    func canMoveToDashboard() -> Observable<Bool>{
        return Observable.combineLatest(emailPS.asObserver().startWith(""), passwordPS.asObservable().startWith("")).map { email, password in
            return email == "ali@gmail.com" && password == "1234"
        }.startWith(false)
    }
    
}

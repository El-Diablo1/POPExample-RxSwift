//
//  DashboardVM.swift
//  PopDemo
//
//  Created by Ale on 05/12/2021.
//

import RxSwift
import RxCocoa
import Foundation

class DashboardVM: LogoutUser{
    let items = PublishSubject<[HomeDataModel]>()
    
    func fetchDashboardList() {
        var tableData = [HomeDataModel]()
        tableData.append(HomeDataModel(name: "Alpha"))
        tableData.append(HomeDataModel(name:"Bravo"))
        tableData.append(HomeDataModel(name:"Charlie"))
        tableData.append(HomeDataModel(name:"David"))
        tableData.append(HomeDataModel(name:"Eliga"))
        tableData.append(HomeDataModel(name:"Fisher"))
        tableData.append(HomeDataModel(name:"Graham"))
        tableData.append(HomeDataModel(name:"Houston"))
        tableData.append(HomeDataModel(name:"Indigo"))
        tableData.append(HomeDataModel(name:"Jack"))
        tableData.append(HomeDataModel(name:"Kate"))
        tableData.append(HomeDataModel(name:"Louis"))
        tableData.append(HomeDataModel(name:"Mocassino"))
        tableData.append(HomeDataModel(name:"Nuke"))
        
        items.onNext(tableData)
        items.onCompleted()
    }
}


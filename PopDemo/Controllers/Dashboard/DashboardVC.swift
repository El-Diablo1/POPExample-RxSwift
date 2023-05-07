//
//  DashboardVC.swift
//  PopDemo
//
//  Created by Ale on 05/12/2021.
//

import UIKit
import RxSwift

class DashboardVC: UIViewController, LogoutUser {

    
    //MARK: - Properties
    
    private let tag = "DashboardVC"
    private let disposeBag = DisposeBag()
    private let viewModel = DashboardVM()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBOutlet weak var dataListTableView: UITableView!
    
    //MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchDashboardList()
    }
}

//MARK: - Custom Methods
extension DashboardVC{
    
    fileprivate func setupBindings(){
        
        dataListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.items.bind(to: dataListTableView.rx.items(cellIdentifier: "Cell", cellType: ItemCell.self)) { _, item, cell in
            cell.bind(item: item)
        }.disposed(by: disposeBag)
        
        dataListTableView.rx.itemSelected.subscribe { indexPath in
            self.dataListTableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        
        dataListTableView.rx.modelSelected(HomeDataModel.self).subscribe(onNext: { item in
            print("Hello: \(item.name ?? "")")
        }).disposed(by: disposeBag)
        
        //Logout
        btnLogout.rx
            .tap.bind{ [weak self] in
                self?.logout()
            }.disposed(by: disposeBag)
    }
}

//MARK: - Tableview Delegate Methods
extension DashboardVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

//MARK: - UITableviewCell
class ItemCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblItemTitle: UILabel!
    
    //MARK: - Custom Methods
    func bind(item: HomeDataModel){
        lblItemTitle.text = item.name
    }

}

//MARK: - Protocol to logout
protocol LogoutUser{
    func logout()
}

extension LogoutUser {
    func logout(){
        (self as! UIViewController).navigationController?.popViewController(animated: true)
    }
}

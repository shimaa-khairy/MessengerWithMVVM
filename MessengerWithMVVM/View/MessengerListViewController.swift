//
//  MessengerListViewController.swift
//  MessengerWithMVVM
//
//  Created by shimaa_khairy on 1/15/22.
//

import UIKit
import RxSwift
import RxCocoa
class MessengerListViewController: UIViewController {
    
    @IBOutlet weak var messengerTableview: UITableView!
    
    @IBOutlet weak var containerView: UIView!
    var viewModel = MessengerViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
        bindSelectedItem()
        bindTableHideen()
        setupNavigationItem()
        
    }
    
    func setupTableview(){
        messengerTableview.register(UINib(nibName: "MessengerCell", bundle: nil), forCellReuseIdentifier: "MessengerCell")
        viewModel.items.bind(to: messengerTableview.rx.items(cellIdentifier: "MessengerCell", cellType: MessengerCell.self)){row,model,cell in
            cell.setData(chatOpject: model)
        }.disposed(by: disposeBag)
        viewModel.fetchItems()
    }
    func bindSelectedItem(){
        Observable.zip(messengerTableview.rx.itemSelected ,messengerTableview.rx.modelSelected(ChatModel.self)).bind{index,model in
            print(model.name ?? "")
            //navigation
        }.disposed(by: disposeBag)
    }
    
    func bindTableHideen(){
        viewModel.tableViewIsHidden.bind(to: containerView.rx.isHidden).disposed(by: disposeBag)
    }
    
    func setupNavigationItem(){
        let messageBtn = UIButton(type: UIButton.ButtonType.custom)
        messageBtn.setImage(UIImage(named: "newMessage"), for: .normal)
        let rightbarButton = UIBarButtonItem(customView: messageBtn)
        self.navigationItem.rightBarButtonItems = [rightbarButton]
        let profileBtn = UIButton(type: UIButton.ButtonType.custom)
        profileBtn.setImage(UIImage(named: "pic"), for: .normal)
        let barButton = UIBarButtonItem(customView: profileBtn)
        self.navigationItem.leftBarButtonItems = [barButton]
    }
}

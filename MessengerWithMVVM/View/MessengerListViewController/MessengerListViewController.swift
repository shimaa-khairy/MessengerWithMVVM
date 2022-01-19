//
//  MessengerListViewController.swift
//  MessengerWithMVVM
//
//  Created by shimaa_khairy on 1/15/22.
//

import UIKit
import RxSwift
import RxCocoa
import Reachability
import RxReachability

class MessengerListViewController: UIViewController {
    
    @IBOutlet weak var messengerTableview: UITableView!
    @IBOutlet weak var ConnectionView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ContainerViewTopConstraint: NSLayoutConstraint!
    
    var viewModel = MessengerViewModel()
    var disposeBag = DisposeBag()
    var reachability: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
        bindSelectedItem()
        bindTableHideen()
        bindReachability()
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
            let vc = UIStoryboard(name: "ChatViewController", bundle: nil).instantiateViewController(identifier: "ChatViewController") as! ChatViewController
            vc.chatModel = model
            vc.row = index.row
            vc.viewModel = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func bindTableHideen(){
        viewModel.tableViewIsHidden.bind(to: containerView.rx.isHidden).disposed(by: disposeBag)
    }
    func bindReachability() {
        Reachability.rx.isReachable
            .subscribe(onNext: { isReachable in
                print("Is reachable: \(isReachable)")
                self.ContainerViewTopConstraint.constant = isReachable ? 0 : 30
            })
            .disposed(by: disposeBag)
        Reachability.rx.isReachable.bind(to: ConnectionView.rx.isHidden).disposed(by: disposeBag)
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

//
//  ChatViewController.swift
//  MessengerWithMVVM
//
//  Created by shimaa_khairy on 1/18/22.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    var chatModel : ChatModel?
    var row : Int?
    var viewModel : MessengerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupview()
    }
    
    func setupview(){
        profileImg.image = UIImage(named: chatModel?.image ?? "")
        name.text = chatModel?.name
        
        let deleteBtn = UIButton(type: UIButton.ButtonType.custom)
        deleteBtn.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteChat), for: .touchUpInside)
        let rightbarButton = UIBarButtonItem(customView: deleteBtn)
        self.navigationItem.rightBarButtonItems = [rightbarButton]
    }
    @objc func deleteChat(){
        let alert = UIAlertController(title: "Confirm", message: "Are You Sure You Wante To Delete This Chat ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            self.viewModel!.removeItem(index: self.row!)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)    }
    
}

//
//  MessengerCell.swift
//  MessengerWithMVVM
//
//  Created by shimaa_khairy on 1/15/22.
//

import Foundation
import UIKit

class MessengerCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var onlineImage: UIImageView!
    @IBOutlet weak var onlineTimeLabel: UILabel!
    @IBOutlet weak var FullNameLabel: UILabel!
    @IBOutlet weak var LastMessageLabel: UILabel!
    
    func setData(chatOpject: ChatModel){
        profileImage.image = UIImage(named: chatOpject.image ?? "")
        FullNameLabel.text = chatOpject.name
        LastMessageLabel.text = chatOpject.lastMessage
        
        if chatOpject.online == 0 {
            // is online now
            onlineImage.backgroundColor = OnlineGreen
            onlineImage.borderWidth = 3
            onlineTimeLabel.text = ""
        }else if (chatOpject.online!<60) {
            //write minites
            onlineImage.backgroundColor = lightGreenColor
                       onlineImage.borderWidth = 3
            onlineTimeLabel.text = "\(chatOpject.online!)m"
                   }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

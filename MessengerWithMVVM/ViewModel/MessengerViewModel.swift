//
//  MessengerViewModel.swift
//  MessengerWithMVVM
//
//  Created by shimaa_khairy on 1/18/22.
//

import Foundation
import RxCocoa
import RxSwift
class MessengerViewModel{
    var items = PublishSubject<[ChatModel]>()
    var tableViewIsHidden = BehaviorRelay<Bool>(value: false)
    var chats = [ChatModel]()
    
    func fetchItems(){
        chats = [
            ChatModel(image:"sh", name: "Shimaa Khairy", lastMessage:"start chat and say Hi ", online: 0),
            ChatModel(image:"mark", name: "Mark", lastMessage:"You: take care . 22:10", online: 0),
            ChatModel(image:"Einstein", name: "Albert Einstein", lastMessage:"start chat and say Hi", online: 70),
            ChatModel(image:"ProfilePic", name: "Shimaa", lastMessage:"You: take care . 22:10", online: 57),
            ChatModel(image:"ProfilePic", name: "Shimaa Khairy", lastMessage:"You: take care .  20:00", online: 70),
            ChatModel(image:"ProfilePic", name: "Shimaa", lastMessage:"You: take care . 22:10", online: 57)]
        tableViewIsHidden.accept(false)
        items.onNext(chats)
    }
    
    func removeItem(index:Int){
        chats.remove(at:index)
        if chats.isEmpty {
            tableViewIsHidden.accept(true)
        }
        items.onNext(chats)
    }
}

// 
//  ChatViewModel.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/8.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import ListFramework
import BasicFramework
import RxSwift
import RxCocoa
import CollectionKit
import Action

class ChatViewModel: Object, ViewModelBehaviours {

    struct Input {
        let headerRefresh: CocoaAction
        let sendText = BehaviorRelay<String?>(value: nil)
    }

    struct Output {
        let reload: CocoaAction
    }

    /// Send Message
    let socketBehaviours: SocketBehaviours

    /// Element -> ImMessage
    let imMessageElementCompoundAdapter: ImMessageElementCompoundAdapter

    /// ImMessage -> Layout
    let imMessageViewLayoutCompoundAdapter: ImMessageViewLayoutCompoundAdapter

    /// Cache ImMessageViewLayout
    let imMessageViewLayoutHolder: ImMessageViewLayoutHolder

    /// Load Message
    let imMessageLoader = DefaultDataBaseImMessageLoader<Int16>()

    init(socketBehaviours: SocketBehaviours,
         imMessageViewLayoutHolder: ImMessageViewLayoutHolder,
         imMessageElementCompoundAdapter: ImMessageElementCompoundAdapter,
         imMessageViewLayoutCompoundAdapter: ImMessageViewLayoutCompoundAdapter) {
        self.socketBehaviours = socketBehaviours
        self.imMessageElementCompoundAdapter = imMessageElementCompoundAdapter
        self.imMessageViewLayoutCompoundAdapter = imMessageViewLayoutCompoundAdapter
        self.imMessageViewLayoutHolder = imMessageViewLayoutHolder
        super.init()
    }
    
    func transform(input: Input) -> Output {
        Observable.just(imMessageLoader.fetchMessage(1))
            .map { [weak self] in self?.imMessageViewLayoutCompoundAdapter.batchAdapt($0) }
            .filterNil()
            .filterEmpty()
            .debug()
            .subscribe(onNext:{ [weak self] in
                self?.imMessageViewLayoutHolder.initializeDataSource($0)
            }).disposed(by: rx.disposeBag)
        
        let imMessage = input.sendText
            .filterNil()
            .map { [weak self] in self?.imMessageElementCompoundAdapter.adapt($0) }
            .filterNil()

        let receivedMessage = socketBehaviours
            .imMessageReceivedCompoundHandler
            .handledMessage
            .filterNil()
            .asObservable()
        
        imMessage
            .subscribe(onNext:{ [weak self] in
                self?.socketBehaviours.sendImMessage($0)
            }).disposed(by: rx.disposeBag)

        Observable.merge(receivedMessage, imMessage)
           .map { [weak self] in self?.imMessageViewLayoutCompoundAdapter.adapt($0) }
           .filterNil()
           .subscribe(onNext:{ [weak self] in
               self?.imMessageViewLayoutHolder.padding($0)
           }).disposed(by: rx.disposeBag)

        return Output.init(reload: imMessageViewLayoutHolder.layoutChanged)
    }

}

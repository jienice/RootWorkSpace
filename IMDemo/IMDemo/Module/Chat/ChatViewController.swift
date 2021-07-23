//
//  ChatViewController.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/1.
//

import UIKit
import CollectionKit
import BasicFramework
import ListFramework
import RxCocoa
import RxSwift
import SnapKit

class ChatViewController: ViewController, ViewControllerBehaviours {
        
    lazy var collectionView = CollectionView()
    
    lazy var inputTextField = UITextField()

    let imMessageChatLayout: ImMessageChatLayout = DefaultImMessageChatLayout()
    
    let viewModel: ChatViewModel

    init(socketBehaviours: SocketBehaviours,
         imMessageViewLayoutHolder: ImMessageViewLayoutHolder,
         imMessageElementCompoundAdapter: ImMessageElementCompoundAdapter,
         imMessageViewLayoutCompoundAdapter: ImMessageViewLayoutCompoundAdapter) {
        viewModel = ChatViewModel(socketBehaviours: socketBehaviours,
                                  imMessageViewLayoutHolder: imMessageViewLayoutHolder,
                                  imMessageElementCompoundAdapter: imMessageElementCompoundAdapter,
                                  imMessageViewLayoutCompoundAdapter: imMessageViewLayoutCompoundAdapter)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = ChatViewModel.Input(headerRefresh: collectionView.rx.headerRefresh)
        
        let output = viewModel.transform(input: input)
        
        output.reload
            .executionObservables
            .switchLatest()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                self?.collectionView.reloadData()
            }).disposed(by: rx.disposeBag)
    }
    
    func setupViews() {
        configCollection()
        view.backgroundColor = DefaultThemeConfiguration.color.background
        title = "chat"
    }
    
    
}

extension ChatViewController {
    
    func configCollection() {
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
        collectionView.alwaysBounceVertical = true
        let textViewSource = ClosureViewSource(viewUpdater: { (view: TextMessageCell, data: DefaultTextMessageViewLayout, at: Int) in
            view.layout = data
        })
        let provider = BasicProvider(
            dataSource: viewModel.imMessageViewLayoutHolder.dataSource,
            viewSource: ComposedViewSource(viewSourceSelector: { _ in
                return textViewSource
            })
        )
        provider.layout = imMessageChatLayout
        collectionView.provider = provider
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//
//  OrderCreatePresenter.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol OrderCreatePresenterProtocol {
    func present(response: OrderCreate.Add.Response)
}

class OrderCreatePresenter: OrderCreatePresenterProtocol {
    
    weak var viewController: OrderCreateDisplayLogic?
    
    func present(response: OrderCreate.Add.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            self.viewController?.display(viewModel: OrderCreate.Add.ViewModel(item: response.item))
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
}

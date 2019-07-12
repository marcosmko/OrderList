//
//  OrderListPresenter.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol OrderListPresenterProtocol {
    func present(response: OrderList.Fetch.Response)
}

class OrderListPresenter: OrderListPresenterProtocol {
    
    weak var viewController: OrderListDisplayLogic?
    
    func present(response: OrderList.Fetch.Response) {
        let blockForExecutionInMainThread: BlockOperation = BlockOperation(block: {
            var items: [OrderList.Fetch.ViewModel.DisplayedItem] = []
            for item in response.items {
                items.append(OrderList.Fetch.ViewModel.DisplayedItem(name: item.name ?? "", unit: item.unit ?? ""))
            }
            self.viewController?.display(viewModel: OrderList.Fetch.ViewModel(displayedItems: items))
        })
        QueueManager.shared.executeBlock(blockForExecutionInMainThread, queueType: .main)
    }
    
}

//
//  OrderListInteractor.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol OrderListInteractorProtocol {
    func fetch(request: OrderList.Fetch.Request)
}

protocol OrderListDataStore {
    var items: [Item] { get set }
}

class OrderListInteractor: OrderListInteractorProtocol, OrderListDataStore {
    var presenter: OrderListPresenterProtocol?
    
    var items: [Item] = []
    
    func fetch(request: OrderList.Fetch.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            self.presenter?.present(response: OrderList.Fetch.Response(items: self.items))
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
}

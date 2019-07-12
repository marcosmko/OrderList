//
//  OrderCreateInteractor.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

protocol OrderCreateInteractorProtocol {
    func add(request: OrderCreate.Add.Request)
}

protocol OrderCreateDataStore {
    var item: Item? { get }
}

class OrderCreateInteractor: OrderCreateInteractorProtocol, OrderCreateDataStore {
    var presenter: OrderCreatePresenterProtocol?
    
    var item: Item?
    
    func add(request: OrderCreate.Add.Request) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            let item: Item = Item()
            item.name = request.name
            item.unit = request.unit
            self.item = item
            self.presenter?.present(response: OrderCreate.Add.Response(item: item))
        })
        QueueManager.shared.executeBlock(blockForExecutionInBackground, queueType: .concurrent)
    }
    
}

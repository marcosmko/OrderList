//
//  OrderListRouter.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation
import UIKit.UIStoryboardSegue

@objc
protocol OrderCreateRouting: class {
    func routeToBack(segue: UIStoryboardSegue, sender: Any?)
}

protocol OrderCreateRouterProtocol: NSObjectProtocol {
    var dataStore: OrderCreateDataStore? { get }
}

class OrderCreateRouter: NSObject, OrderCreateRouterProtocol, OrderCreateRouting {
    var dataStore: OrderCreateDataStore?
    
    func routeToBack(segue: UIStoryboardSegue, sender: Any?) {
         guard let dataStore = self.dataStore,
             let destinationVC = segue.destination as? OrderListViewController,
             var destinationDS = destinationVC.router?.dataStore else {
                 return
         }
         self.passDataToShowDetail(source: dataStore, destination: &destinationDS, sender: sender)
    }
    
    // MARK: Passing data
    
    private func passDataToShowDetail(source: OrderCreateDataStore, destination: inout OrderListDataStore, sender: Any?) {
        guard let item = source.item else { return }
        destination.items.append(item)
    }

}

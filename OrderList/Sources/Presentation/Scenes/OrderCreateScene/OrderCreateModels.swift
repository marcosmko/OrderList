//
//  MarsModels.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

enum OrderCreate {
    
    enum Add {
        struct Request {
            let name: String
            let unit: String
        }
        struct Response {
            let item: Item
        }
        struct ViewModel {
            let item: Item
        }
    }
    
}

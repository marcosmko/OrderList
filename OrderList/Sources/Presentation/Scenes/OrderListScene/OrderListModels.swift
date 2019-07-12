//
//  MarsModels.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import Foundation

enum OrderList {
    
    enum Fetch {
        struct Request {
        }
        struct Response {
            let items: [Item]
        }
        struct ViewModel {
            struct DisplayedItem {
                let name: String
                let unit: String
            }
            var displayedItems: [DisplayedItem]
        }
    }
    
}

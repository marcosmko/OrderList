//
//  ItemCell.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 12/07/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var unitLabel: UILabel!
    
    func prepare(viewModel: OrderList.Fetch.ViewModel.DisplayedItem) {
        self.nameLabel.text = viewModel.name
        self.unitLabel.text = viewModel.unit
    }
    
}

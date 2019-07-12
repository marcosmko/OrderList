//
//  OrderListViewController.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol OrderListDisplayLogic: class {
    func display(viewModel: OrderList.Fetch.ViewModel)
}

class OrderListViewController: UIViewController, OrderListDisplayLogic {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var emptyStateView: UIView!
    @IBOutlet private var addButton: UIButton!
    
    var interactor: OrderListInteractorProtocol?
    var router: OrderListRouterProtocol?
    var displayedItems: [OrderList.Fetch.ViewModel.DisplayedItem] = []
    
    private func setup() {
        let viewController = self
        let interactor = OrderListInteractor()
        let presenter = OrderListPresenter()
        let router = OrderListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor?.fetch(request: OrderList.Fetch.Request())
    }
    
    func display(viewModel: OrderList.Fetch.ViewModel) {
        self.displayedItems = viewModel.displayedItems
        self.emptyStateView.isHidden = !self.displayedItems.isEmpty
        self.addButton.isHidden = self.displayedItems.isEmpty
        self.tableView.reloadData()
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let router = self.router, let identifier = segue.identifier else { return }
        let selector = NSSelectorFromString("routeTo\(identifier)WithSegue:sender:")
        if router.responds(to: selector) {
            router.perform(selector, with: segue, with: sender)
        }
    }
    
}

extension OrderListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let viewModel = self.displayedItems[indexPath.row]
        (cell as? ItemCell)?.prepare(viewModel: viewModel)
        return cell
    }
    
}

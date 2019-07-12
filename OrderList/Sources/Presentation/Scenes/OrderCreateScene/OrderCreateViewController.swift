//
//  OrderListViewController.swift
//  OrderList
//
//  Created by Marcos Kobuchi on 02/02/19.
//  Copyright © 2019 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol OrderCreateDisplayLogic: class {
    func display(viewModel: OrderCreate.Add.ViewModel)
}

class OrderCreateViewController: UIViewController, OrderCreateDisplayLogic {
    
    var interactor: OrderCreateInteractorProtocol?
    var router: OrderCreateRouterProtocol?
    
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var unitButtons: [UIButton]!
    
    @IBOutlet private var customButton: UIButton!
    @IBOutlet private var customUnitTextField: UITextField!
    
    private var unit: String?
    
    private func setup() {
        let viewController = self
        let interactor = OrderCreateInteractor()
        let presenter = OrderCreatePresenter()
        let router = OrderCreateRouter()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeUnit(self.unitButtons[0])
    }
    
    @IBAction private func changeUnit(_ sender: UIButton) {
        for button in self.unitButtons where button != sender {
            button.backgroundColor = .white
            button.setTitleColor(.gray, for: .normal)
        }
        self.unit = sender.title(for: .normal)
        sender.backgroundColor = .blue
        sender.setTitleColor(UIColor.white, for: .normal)
        self.customUnitTextField.isHidden = (sender != self.customButton)
    }
    
    @IBAction private func add(_ sender: Any) {
        if self.unit == "Custom" {
            self.unit = self.customUnitTextField.text
        }
        self.interactor?.add(request: OrderCreate.Add.Request(name: self.nameTextField.text ?? "", unit: self.unit ?? ""))
    }
    
    func display(viewModel: OrderCreate.Add.ViewModel) {
        self.performSegue(withIdentifier: "Back", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let router = self.router, let identifier = segue.identifier else { return }
        let selector = NSSelectorFromString("routeTo\(identifier)WithSegue:sender:")
        if router.responds(to: selector) {
            router.perform(selector, with: segue, with: sender)
        }
    }
    
}

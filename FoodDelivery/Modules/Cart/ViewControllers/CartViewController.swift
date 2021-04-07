//
//  CartViewController.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit
import WMSegmentControl
import RxSwift
import RxCocoa
import Floaty

protocol CartViewProtocol: class {
    func showCartItems()
}

class CartViewController: UIViewController {
    @IBOutlet weak var segmentControl: WMSegment!
    @IBOutlet weak var cartScrollView: UIScrollView!
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var deliveryFare: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var deliveryFareLabel: UILabel!
    
    var presenter: CartPresenterProtocol?
    private var emptyCartLabel = UILabel()
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setupView()
        
        // Load date from Presenter
        self.presenter?.loadViewData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Floaty.global.hide()
    }
    
    private func setupView() {
        configView()
        setupSegmentControl()
        setupTableView()
        setupCartObserver()
        setupEmptyCartLabel()
    }
    
    private func configView() {
        self.emptyCartLabel.isHidden = true
        self.valueLabel.isHidden = true
        self.deliveryFareLabel.isHidden = true
        self.totalPrice.isHidden = true
    }
    
    private func setupSegmentControl() {
        self.segmentControl.buttonTitles = "Cart,Oders,Info"
        self.segmentControl.SelectedFont = UIFont.boldSystemFont(ofSize: 30)
        self.segmentControl.normalFont = UIFont.systemFont(ofSize: 30)
        
        self.segmentControl.onValueChanged = { index in
            print("Selected view index: \(index)")
            
            if index == 0 { // 0 = cart
                self.cartScrollView.isHidden = false
            } else {
                self.cartScrollView.isHidden = true
            }
        }
    }
    
    private func setupTableView() {
        productTable.dataSource = self
        productTable.delegate = self
        productTable.separatorStyle = .none
        
        productTable.register(CartViewTableCell.loadNib(),
                              forCellReuseIdentifier: CartViewTableCell.reuseIdentifier())
    }
    
    private func setupCartObserver() {
        self.presenter?.getCartObject().foodItems
          .asObservable()
          .subscribe(onNext: {
            [unowned self] foodItems in
            
            self.reloadProductTable()
            self.updateTotalPrice()
          })
          .disposed(by: disposeBag)
    }
    
    
    private func updateTotalPrice() {
        let totalPrice = self.presenter?.getTotalPrice() ?? 0
        if totalPrice > 0 {
            let price = totalPrice
            self.totalPrice.text = "\(price) USD"
            self.deliveryFareLabel.text = self.presenter?.getDeliveryFare()
            
            self.valueLabel.isHidden = false
            self.deliveryFareLabel.isHidden = false
            self.totalPrice.isHidden = false
        } else {
            // Hide price tag
            self.valueLabel.isHidden = true
            self.deliveryFareLabel.isHidden = true
            self.totalPrice.isHidden = true
        }
    }
    
    private func reloadProductTable() {
        let items = self.presenter?.getCartItems() ?? [FoodItem]()
        
        if items.count > 0 {
            self.productTable.isHidden = false
            self.emptyCartLabel.isHidden = true
            
            self.productTable.reloadData()
        } else {
            self.productTable.isHidden = true
            self.emptyCartLabel.isHidden = false
        }
    }
    
    private func setupEmptyCartLabel() {
        self.emptyCartLabel = UILabel(frame: CGRect(x: 40,
                                                    y: UIScreen.main.bounds.size.width/2,
                                                    width: UIScreen.main.bounds.width,
                                                    height: 50))
        self.emptyCartLabel.text = "You haven't added anything to your cart!"
        self.cartScrollView.addSubview(self.emptyCartLabel)
        
    }
}

// MARK:- UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.getCartItems().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = CartViewTableCell.reuseIdentifier()
        
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellIdentifier,
                                 for: indexPath) as? CartViewTableCell else {
            
            print("The dequeued cell is not an instance of CartViewTableCell")
            return UITableViewCell()
        }
        
        let items = self.presenter?.getCartItems() ?? [FoodItem]()
        let item = items[indexPath.section]
        
        if let imageName = item.image {
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        cell.name.text = item.name ?? ""
        
        let price = item.price ?? 0
        cell.price.text = "\(price) USD"
        
        cell.clearButton.tag = indexPath.section
        cell.clearButton.addTarget(self, action: #selector(removeFromCart(sender:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK:- UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CartViewController {
    @objc func removeFromCart(sender: UIButton) {
        let tag = sender.tag
        
        if let items = self.presenter?.getCartItems(),
            items.count > tag {
            
            let item = items[tag]
            self.presenter?.removeFromCart(item)
        }
    }
}


extension CartViewController: CartViewProtocol {
    func showCartItems() {
        self.reloadProductTable()
        self.updateTotalPrice()
    }
    
}


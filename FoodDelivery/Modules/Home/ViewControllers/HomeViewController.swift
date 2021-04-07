//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 3/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit
import WMSegmentControl
import Floaty
import BadgeControl
import RxSwift
import RxCocoa

protocol HomeViewProtocol: class {
    func showHomeBanners()
    func showFoodItems()
    func showError()
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var topImageScrollView: UIScrollView!
    @IBOutlet weak var topImagePageControl: UIPageControl!
    @IBOutlet weak var categorySegmentControl: WMSegment!
    @IBOutlet weak var foodListView: UIView!
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var filterSpicy: UIButton!
    @IBOutlet weak var filterVegan: UIButton!
    
    var presenter: HomePresenterProtocol?
    var selectedCateogry: Int = 0
    var badge: BadgeController?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "Menu"
        setupView()
        
        // Load date from Presenter
        self.presenter?.loadViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        Floaty.global.show()
    }
    
}

extension HomeViewController {
    private func setupView() {
        
        self.setupHomeBanners()
        
        self.setupCartObserver()
        
        self.configView()
        
        self.setupSegmentControl()
        
        self.setupTableView()
        
        self.setupCartFloatyButtonWithBadge()
    }
    
    private func configView() {
        self.foodListView.roundedConrner(radius: 30.0)
        self.filterSpicy.layer.borderColor = UIColor.lightGray.cgColor
        self.filterVegan.layer.borderColor = UIColor.lightGray.cgColor
        self.filterSpicy.layer.borderWidth = 0.4
        self.filterVegan.layer.borderWidth = 0.4
        
        self.filterSpicy.roundedConrner(radius: 10.0)
        self.filterVegan.roundedConrner(radius: 10.0)
    }
    
    private func setupCartObserver() {
        let cart = self.presenter?.getCartObject() ?? ShoppingCart()
        cart.foodItems
            .asObservable()
            .subscribe(onNext: {
                [unowned self] foodItems in
                
                if cart.totalItems > 0 {
                    self.badge?.addOrReplaceCurrent(with: "\(cart.totalItems)", animated: true)
                } else {
                    self.badge?.remove(animated: false)
                }
            })
            .disposed(by: disposeBag)
    }

    private func setupSegmentControl() {
        self.categorySegmentControl.buttonTitles = self.presenter?.getCateogryName() ?? ""
        self.categorySegmentControl.SelectedFont = UIFont.boldSystemFont(ofSize: 34)
        self.categorySegmentControl.normalFont = UIFont.systemFont(ofSize: 34)
        
        self.selectedCateogry = self.categorySegmentControl.selectedSegmentIndex
        
        self.categorySegmentControl.onValueChanged = { index in
            print("Selected cateogry: \(index)")
            self.selectedCateogry = index
            
            self.foodTableView.setContentOffset(.zero, animated: true)
            self.foodTableView.reloadData()
        }
    }
    
    private func setupHomeBanners() {
        self.topImageScrollView.isPagingEnabled = true
        self.topImageScrollView.showsVerticalScrollIndicator = false
        self.topImageScrollView.showsHorizontalScrollIndicator = false
        self.topImageScrollView.frame = CGRect(x: 0, y: 0,
                                               width: UIScreen.main.bounds.size.width,
                                               height: self.topImageScrollView.frame.height)
    }
    
    private func setupImagesToScrollView(_ banners: [HomeBanner]) {
        for (i, banner) in banners.enumerated() {
            let imageView = UIImageView()
            
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            
            // Fetch banners
            if let bannerImage = banner.image {
                self.presenter?.onFetchBanner(name: bannerImage) { image in
                    imageView.image = image
                }
            }
            
            let xPosition: CGFloat = UIScreen.main.bounds.size.width * CGFloat(i);
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: self.topImageScrollView.frame.width,
                                     height: self.topImageScrollView.frame.height)
            
            self.topImageScrollView.contentSize = CGSize(width: self.topImageScrollView.frame.width * CGFloat(i+1),
                                                         height: self.topImageScrollView.frame.height)
            
            self.topImageScrollView.addSubview(imageView)
            self.topImageScrollView.delegate = self
            
            // Default photo
            imageView.image = UIImage(named: banner.image ?? "")
        }
    }
    
    private func setupPageControl(_ count: Int) {
        self.topImagePageControl.numberOfPages = count
        self.topImagePageControl.currentPage = 0
        self.view.bringSubviewToFront(topImagePageControl)
    }

    private func setupTableView() {
        
        self.mainScrollView.setContentOffset(.zero, animated: true)
        foodTableView.dataSource = self
        foodTableView.delegate = self
        foodTableView.separatorStyle = .none
        
        foodTableView.register(FoodItemTableViewCell.loadNib(),
                               forCellReuseIdentifier: FoodItemTableViewCell.reuseIdentifier())
    }
    
    private func setupCartFloatyButtonWithBadge() {
        Floaty.global.button.buttonColor = .white
        Floaty.global.button.buttonImage = UIImage(systemName: "cart")
        Floaty.global.show()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCartButtonAction(sender:)))
        Floaty.global.button.addGestureRecognizer(tapGesture)
        
        badge = BadgeController(for: Floaty.global.button)
        badge?.badgeBackgroundColor = .green
        badge?.badgeTextColor = .white
        badge?.badgeTextFont = UIFont.boldSystemFont(ofSize: 10)
        badge?.borderWidth = 0.0
        badge?.borderColor = .black
        badge?.animation = BadgeAnimations.defaultAnimation
        badge?.badgeHeight = 20
        badge?.centerPosition = .custom(x: 50, y: 10)
    }
    
}

extension HomeViewController : HomeViewProtocol {
    func showHomeBanners() {
        if let banners = self.presenter?.getHomeBanners() {
            // Add images to scroll view
            setupImagesToScrollView(banners)
            
            // Setup page control
            setupPageControl(banners.count)
        }
    }
    
    func showFoodItems() {
        self.foodTableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: CPLocalizeText.TEXT_ALERT,
                                      message: CPLocalizeText.TEXT_PROBLEM_FETCHING_CLASSIFIED_ITEMS,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let alertOkAction = UIAlertAction(title: CPLocalizeText.TEXT_OK,
                                          style: .default, handler: {(_: UIAlertAction) in
            
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(alertOkAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK:- UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.presenter?.getFoodItemsByCategoryId(self.selectedCateogry).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = FoodItemTableViewCell.reuseIdentifier()
        
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: cellIdentifier,
                                 for: indexPath) as? FoodItemTableViewCell else {
            
            print("The dequeued cell is not an instance of FoodItemTableViewCell")
            return UITableViewCell()
        }
        
        let items = self.presenter?.getFoodItemsByCategoryId(self.selectedCateogry) ?? [FoodItem]()
        let item = items[indexPath.section]
        
        cell.titleLabel.text = item.name ?? ""
        cell.subtitleLabel.text = item.description ?? ""
        cell.descriptionLabel.text = "\(item.weight ?? ""), \(item.length ?? "")"
        
        let price = item.price ?? 0
        cell.priceButton.setTitle("\(price) USD", for: .normal)
        cell.priceButton.tag = indexPath.section
        
        cell.priceButton.addTarget(self, action: #selector(handleAddToCart(sender:)), for: .touchUpInside)
        
        if let imageName = item.image {
            self.presenter?.onFetchImage(name: imageName) { image in
                cell.foodImage.image = image
            }

            cell.foodImage.image = UIImage(named: "defaultPhoto")
        }
        
        // Style Cell
        cell.roundedConrner(radius: 20.0)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK:- UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController {
    @objc func handleCartButtonAction(sender: UITapGestureRecognizer) {
        print("Tap cart button")
        
        self.presenter?.moveToCartView()
    }
    
    @objc func handleAddToCart(sender: UIButton) {
        let tag = sender.tag
        let items = self.presenter?.getFoodItemsByCategoryId(self.selectedCateogry) ?? [FoodItem]()
        let item = items[tag]
        
        self.presenter?.addToCart(item)
        
        let bgColor = sender.backgroundColor
        let title = sender.title(for: .normal)
        UIView.transition(with: sender, duration: 0.8, options: .curveEaseIn, animations: {
            sender.backgroundColor = .green
            sender.setTitle("added +1", for: .normal)
            sender.setTitleColor(.white, for: .normal)
        }, completion: { _ in
            UIView.transition(with: sender, duration: 0.6, options: .curveEaseOut, animations: {
                sender.backgroundColor = bgColor
                sender.setTitle(title, for: .normal)
            })
        })
    }
    
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex: Double = Double(round(self.topImageScrollView.contentOffset.x / self.view.frame.width))
        self.topImagePageControl.currentPage = Int(pageIndex)
    }
}

extension UIView {
    func roundedConrner(radius: Double) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
}

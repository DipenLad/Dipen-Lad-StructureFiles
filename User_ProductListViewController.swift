//
//  User_ProductListViewController.swift
//  A2-Milk
//
//  Created by Dipen on 29/01/20.
//  Copyright © 2020 A2Milk. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import LGSideMenuController

class User_ProductListViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource
{
    // MARK: - IBOutlet
    @IBOutlet var statusBarContainerView: UIView?
    @IBOutlet var homeBarContainerView: UIView?
    @IBOutlet var masterContainerView: UIView?
    
    //NAVIGATION BAR
    @IBOutlet var navigationBarView: UIView?
    //LOCATION
    @IBOutlet var locationContainerView: UIView?
    @IBOutlet var imageViewLocation: UIImageView?
    @IBOutlet var lblLocation: UILabel?
    //CART
    @IBOutlet var cartContainerView: UIView?
    @IBOutlet var imageViewCart: UIImageView?
    @IBOutlet var btnCart: UIButton?
    //MENU
    @IBOutlet var menuContainerView: UIView?
    @IBOutlet var imageViewMenu: UIImageView?
    @IBOutlet var btnMenu: UIButton?
    
    @IBOutlet var categoriesCollectionView: UICollectionView?
    @IBOutlet var productsTableView: UITableView?
    
    // MARK: - Other Variables
    
    var appDelegate: AppDelegate?
    var boolIsSetupNotificationEventCalledOnce: Bool = false
    
    var intSelectedProductIndex: Int?
    
    var dataRowsCategory = [ObjCategory]()
    var objSelectedCategory: ObjCategory = ObjCategory()
    
    // MARK: - UIViewController Delegate Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataRowsCategory = dataManager.arrayAllCategories
        objSelectedCategory = dataRowsCategory[0]

        self.setupNotificationEvent()
        self.setUpNavigationBar()
        self.setupInitialView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //API CALL
        dataManager.getSplashResponce()
        
        self.setupNotificationEvent()
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return .default
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        
        self.removeNotificationEventObserver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Notification Methods
    
    func setupNotificationEvent()
    {
        if(boolIsSetupNotificationEventCalledOnce == false)
        {
            boolIsSetupNotificationEventCalledOnce = true
            
            NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.getSplashResponceEvent),
            name: Notification.Name("getSplashResponceEvent"),
            object: nil)
        }
    }
    
    func removeNotificationEventObserver()
    {
        boolIsSetupNotificationEventCalledOnce = false
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func getSplashResponceEvent()
    {
        DispatchQueue.main.async(execute: {
            
            self.dataRowsCategory = dataManager.arrayAllCategories
            self.objSelectedCategory = self.dataRowsCategory[0]
            self.categoriesCollectionView?.reloadData()
            self.productsTableView?.reloadData()
        })
    }
    
    // MARK: - Layout Subviews Methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    
    // MARK: - NavigationBar Methods
    
    func setUpNavigationBar()
    {
        statusBarContainerView?.backgroundColor = MySingleton.sharedManager().navigationBarBackgroundColor
        navigationBarView?.backgroundColor = MySingleton.sharedManager().navigationBarBackgroundColor
        
        lblLocation?.font = MySingleton.sharedManager().themeFontFourteenSizeRegular
        lblLocation?.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        lblLocation?.numberOfLines = 2
        
        btnCart?.addTarget(self, action: #selector(self.btnCartClicked(_:)), for: .touchUpInside)
        
        btnMenu?.addTarget(self, action: #selector(self.btnMenuClicked(_:)), for: .touchUpInside)
    }
    
    @IBAction func btnCartClicked(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        let viewController: User_ShoppingCartViewController = User_ShoppingCartViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func btnMenuClicked(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if(self.sideMenuController?.isRightViewVisible)!
        {
            self.sideMenuController?.hideRightViewAnimated()
        }
        else
        {
            self.sideMenuController?.showRightView(animated: true, completionHandler: nil)
        }
    }
    
    // MARK: - Setting Initial Views Methods
    
    func setupInitialView()
    {
        //self.automaticallyAdjustsScrollViewInsets = false
        
        masterContainerView?.backgroundColor = MySingleton.sharedManager().themeGlobalPurpleColor
        homeBarContainerView?.backgroundColor = MySingleton.sharedManager().themeGlobalPurpleColor
        
        categoriesCollectionView?.delegate = self
        categoriesCollectionView?.dataSource = self
        categoriesCollectionView?.backgroundColor = MySingleton.sharedManager() .themeGlobalPurpleColor
        
        
        productsTableView?.delegate = self
        productsTableView?.dataSource = self
        productsTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        productsTableView?.backgroundColor = MySingleton.sharedManager() .themeGlobalPurpleColor
    }
    
    // MARK: UIcollectionView Delegation
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataRowsCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellWidth: CGFloat = CGFloat(100)
        let cellHeight: CGFloat = collectionView.frame.size.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reusableIdentifier = NSString(format:"Cell-1:%d", indexPath.item) as String
        
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        cell.lblOptionName.text = dataRowsCategory[indexPath.item].strCategoryName
            
        if (dataRowsCategory[indexPath.item].strCategoryID == objSelectedCategory.strCategoryID)
        {
            cell.innerContainer.backgroundColor = MySingleton.sharedManager().themeGlobalYellowColor
            cell.lblOptionName.textColor = MySingleton.sharedManager().themeGlobalBlackColor
        }
        else
        {
            cell.innerContainer.backgroundColor = MySingleton.sharedManager().themeGlobalWhiteColor
            cell.lblOptionName.textColor = MySingleton.sharedManager().themeGlobalDarkGreyColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        objSelectedCategory = dataRowsCategory[indexPath.item]
        categoriesCollectionView?.reloadData()
        productsTableView?.reloadData()
    }
    
    // MARK: - UITableView Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return objSelectedCategory.arrayProducts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CartItemTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reusableIdentifier = NSString(format:"cell-1:%d", indexPath.row) as String
        
        //========== TABLEVIEW CELL PROGRAMMATICALLY ==========//
        var cell:CartItemTableViewCell! = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as? CartItemTableViewCell
        
        if(cell == nil)
        {
            cell = CartItemTableViewCell(style: .default, reuseIdentifier: reusableIdentifier)
        }
        
        cell.imageViewItem.sd_setImage(with: URL(string: objSelectedCategory.arrayProducts[indexPath.row].strImageURL), placeholderImage: UIImage(named: "ic_launcher.png"))
    
        cell.lblProductName.text = objSelectedCategory.arrayProducts[indexPath.row].strProductName
        cell.lblPromotionText.text = objSelectedCategory.arrayProducts[indexPath.row].strProductDescription
        cell.lblPrice.text = "₹ \(objSelectedCategory.arrayProducts[indexPath.row].strPrice)"
        
        cell.lblQty.text = "Qty: 1"
        cell.lblQty.frame.origin.x = 0
        cell.lblQty.textAlignment = .left
        
        cell.btnRemove.isHidden = true
        cell.btnMinus.isHidden = true
        cell.btnPlus.isHidden = true
        
        if (objSelectedCategory.strCategoryID == "1")
        {
            cell.lblPromotionText.isHidden = true
            cell.lblPrice.isHidden = true
            cell.lblQty.isHidden = true
        }
        else
        {
            cell.lblPromotionText.isHidden = false
            cell.lblPrice.isHidden = false
            cell.lblQty.isHidden = false
        }
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if ("\(UserDefaults.standard.value(forKey: "is_logged_in") ?? "")" == "1")
        {
            if (objSelectedCategory.strCategoryID == "1")
            {
                if (Int(objSelectedCategory.arrayProducts[indexPath.row].strCredits)! > 0)
                {
                    //CALANDER
                    let viewController: User_OrderMilkViewController = User_OrderMilkViewController()
                    let user_SideMenuViewController: User_SideMenuViewController = User_SideMenuViewController()
                    
                    let navigationController = UINavigationController(rootViewController: viewController)
                    
                    let sideMenuController = LGSideMenuController(rootViewController: navigationController,
                                                                  leftViewController: nil,
                                                                  rightViewController: user_SideMenuViewController)
                    
                    sideMenuController.leftViewWidth = MySingleton.sharedManager().floatLeftSideMenuWidth!
                    sideMenuController.leftViewPresentationStyle = MySingleton.sharedManager().leftViewPresentationStyle!
                    
                    sideMenuController.rightViewWidth = MySingleton.sharedManager().floatRightSideMenuWidth!
                    sideMenuController.rightViewPresentationStyle = MySingleton.sharedManager().rightViewPresentationStyle!
                    sideMenuController.isLeftViewSwipeGestureEnabled = false
                    sideMenuController.isRightViewSwipeGestureEnabled = false
                    
                    self.navigationController?.pushViewController(sideMenuController, animated: false)
                }
                else
                {
                    let viewController: User_packageListViewController = User_packageListViewController()
                    viewController.objSelectedProduct = objSelectedCategory.arrayProducts[indexPath.row]
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
                
            }
            else
            {
                //API CALL FOR ADD TO CART
            }
        }
        else
        {
            let viewController: User_LoginViewController = User_LoginViewController()
            self.navigationController?.pushViewController(viewController, animated: false)
        }
        
    }
    
    // MARK: - UITextField Delagate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}

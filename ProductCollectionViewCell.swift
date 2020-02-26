//
//  ProductCollectionViewCell.swift
//  A2-Milk
//
//  Created by Dipen on 29/01/20.
//  Copyright © 2020 A2Milk. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell
{
    var mainContainer: UIView = UIView()
    var innerContainer: UIView = UIView()
    var lblOptionName: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let cellWidth:CGFloat = frame.width
        let cellHeight:CGFloat = frame.height
        
        //======= ADD MAIN CONTAINER VIEW =======//
        mainContainer = UIView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        mainContainer.backgroundColor = .clear
        
        //======= ADD INNER CONTAINER VIEW =======//
        innerContainer = UIView(frame: CGRect(x: 5, y: 5, width: cellWidth - 10, height: cellHeight - 10))
        innerContainer.backgroundColor = MySingleton.sharedManager().themeGlobalWhiteColor
        innerContainer.clipsToBounds = true
        innerContainer.layer.cornerRadius = innerContainer.frame.size.height / 2
        
        //======= ADD LBL OPTION NAME MAIN INTO MAIN CONTAINER VIEW =======//
        lblOptionName = UILabel(frame: CGRect(x: innerContainer.frame.size.height / 2, y: 0, width: innerContainer.frame.size.width - innerContainer.frame.size.height, height: innerContainer.frame.size.height))
        lblOptionName.font = MySingleton.sharedManager().themeFontTwelveSizeRegular
        lblOptionName.textColor =  MySingleton.sharedManager().themeGlobalDarkGreyColor
        lblOptionName.textAlignment = .center
        lblOptionName.numberOfLines = 1
        lblOptionName.adjustsFontSizeToFitWidth = true
        innerContainer.addSubview(lblOptionName)
        
        mainContainer.addSubview(innerContainer)
        self.contentView.addSubview(mainContainer)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

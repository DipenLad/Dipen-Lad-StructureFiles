//
//  MilkOrderTableViewCell.swift
//  A2-Milk
//
//  Created by Dipen on 01/02/20.
//  Copyright © 2020 A2Milk. All rights reserved.
//

import UIKit
var MilkOrderTableViewCellHeight: CGFloat = 40

class MilkOrderTableViewCell: UITableViewCell
{
    var mainContainer: UIView = UIView()
    var innerContainer: UIView = UIView()
    var lblDate: UILabel = UILabel()
    var lblDay: UILabel = UILabel()
    var lblQty: UILabel = UILabel()
    var lblStatus: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = bgColorView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //======= MAIN CONTAINER VIEW =======//
        mainContainer = UIView(frame: CGRect(x: 0, y: 0, width: MySingleton.sharedManager().screenWidth, height: MilkOrderTableViewCellHeight))
        mainContainer.backgroundColor = UIColor.clear
        
        //======= INNER CONTAINER VIEW =======//
        innerContainer = UIView(frame: CGRect(x: 10, y: 0, width: mainContainer.frame.size.width - 20, height: mainContainer.frame.size.height))
        innerContainer.backgroundColor = MySingleton.sharedManager().themeGlobalLightPurpleColor
        
        let width: CGFloat = innerContainer.frame.size.width / 4
        
        //======= LBL DATE =======//
        lblDate = UILabel(frame: CGRect(x: 5, y: 0, width: width - 10, height: innerContainer.frame.size.height))
        lblDate.font = MySingleton.sharedManager().themeFontFourteenSizeRegular
        lblDate.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        lblDate.textAlignment = .center
        innerContainer.addSubview(lblDate)
        
        //======= LBL DAY =======//
        lblDay = UILabel(frame: CGRect(x: width + 5, y: 0, width: width - 10, height: innerContainer.frame.size.height))
        lblDay.font = MySingleton.sharedManager().themeFontFourteenSizeRegular
        lblDay.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        lblDay.textAlignment = .center
        innerContainer.addSubview(lblDay)
        
        //======= LBL QTY =======//
        lblQty = UILabel(frame: CGRect(x: (width * 2) + 5, y: 0, width: width - 10, height: innerContainer.frame.size.height))
        lblQty.font = MySingleton.sharedManager().themeFontFourteenSizeRegular
        lblQty.textColor = MySingleton.sharedManager().themeGlobalWhiteColor
        lblQty.textAlignment = .center
        innerContainer.addSubview(lblQty)
        
        //======= LBL STATUS =======//
        lblStatus = UILabel(frame: CGRect(x: (width * 3) + 5, y: 10, width: width - 10, height: innerContainer.frame.size.height - 20))
        lblStatus.font = MySingleton.sharedManager().themeFontTwelveSizeRegular
        lblStatus.textColor = MySingleton.sharedManager().themeGlobalBlackColor
        lblStatus.backgroundColor = MySingleton.sharedManager().themeGlobalYellowColor
        lblStatus.clipsToBounds = true
        lblStatus.layer.cornerRadius = lblStatus.frame.size.height / 2
        lblStatus.textAlignment = .center
        lblStatus.text = "Pending"
        innerContainer.addSubview(lblStatus)
        
        mainContainer.addSubview(innerContainer)
        self.addSubview(mainContainer)
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
    }

}

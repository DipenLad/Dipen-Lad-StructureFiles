//
//  MySingleton.swift
//  SwiftDemo
//
//  Created by Infusion on 6/5/15.
//  Copyright (c) 2015 Infusion. All rights reserved.
//

import UIKit
import Foundation

import LGSideMenuController.LGSideMenuController
import LGSideMenuController.UIViewController_LGSideMenuController

class MySingleton: NSObject
{
    var screenRect: CGRect
    var screenWidth: CGFloat
    let screenHeight: CGFloat
    
    //========================= APPLICATION SPECIFIC SETTINGS ================//
    
    //========================= SIDE MENU SETTINGS ================//
    
    var selectedScreenIndex: NSInteger
    
    var floatLeftSideMenuWidth: CGFloat?
    var floatRightSideMenuWidth: CGFloat?
    
    var leftViewPresentationStyle: LGSideMenuPresentationStyle?
    var rightViewPresentationStyle: LGSideMenuPresentationStyle?
    
    //========================= NAVIGATION BAR SETTINGS ================/
    var navigationBarBackgroundColor: UIColor?
    var navigationBarTitleColor: UIColor?
    var navigationBarTitleFont: UIFont?
    var navigationBarTitleSmallFont: UIFont?
    
    //========================= TAB BAR SETTINGS ================//
    var tabBarBackgroundColor: UIColor?
    var tabBarTitleColor: UIColor?
    var tabTitleFont: UIFont?
    
    //========================= THEME GLOBAL COLORS SETTINGS ================//
    var themeGlobalBackgroundGreyColor: UIColor?
    
    var themeGlobalPurpleColor: UIColor?
    var themeGlobalLightPurpleColor: UIColor?
    var themeGlobalYellowColor: UIColor?
    var themeGlobalBlueColor: UIColor?
    var themeGlobalGreenColor: UIColor?
    var themeGlobalLightGreenColor: UIColor?
    var themeGlobalRedColor: UIColor?
    var themeGlobalWhiteColor: UIColor?
    var themeGlobalBlackColor: UIColor?
    var themeGlobalDarkGreyColor: UIColor?
    var themeGlobalLightGreyColor: UIColor?
    var themeGlobalLightestGreyColor: UIColor?
    var themeGlobalSeperatorGreyColor: UIColor?
    var themeGlobalSideMenuSeperatorColor: UIColor?
    
    var textfieldPlaceholderColor: UIColor?
    var textfieldTextColor: UIColor?
    var textfieldRedTextColor: UIColor?
    var textfieldDisabledTextColor: UIColor?
    var textfieldFloatingLabelTextColor: UIColor?
    var textfieldBottomSeparatorColor: UIColor?
    
    var textfieldPlaceholderLoginColor: UIColor?
    var textfieldTextLoginColor: UIColor?
    
    //========================= THEME GLOBAL CUSTOM COLORS SETTINGS ================//
    var themeGlobalOrangeColor: UIColor?
    var themeGlobalFacebookColor: UIColor?
    var themeGlobalGoogleColor: UIColor?
    
    //========================= FLOAT VALUES SETTINGS ================//
    var floatButtonCornerRadius: CGFloat?
    
    //========================= THEME REGULAR FONTS SETTING ================//
    var themeFontFourSizeRegular: UIFont?
    var themeFontFiveSizeRegular: UIFont?
    var themeFontSixSizeRegular: UIFont?
    var themeFontSevenSizeRegular: UIFont?
    var themeFontEightSizeRegular: UIFont?
    var themeFontNineSizeRegular: UIFont?
    var themeFontTenSizeRegular: UIFont?
    var themeFontElevenSizeRegular: UIFont?
    var themeFontTwelveSizeRegular: UIFont?
    var themeFontThirteenSizeRegular: UIFont?
    var themeFontFourteenSizeRegular: UIFont?
    var themeFontFifteenSizeRegular: UIFont?
    var themeFontSixteenSizeRegular: UIFont?
    var themeFontSeventeenSizeRegular: UIFont?
    var themeFontEighteenSizeRegular: UIFont?
    var themeFontNineteenSizeRegular: UIFont?
    var themeFontTwentySizeRegular: UIFont?
    var themeFontTwentyOneSizeRegular: UIFont?
    var themeFontTwentyTwoSizeRegular: UIFont?
    var themeFontTwentyThreeSizeRegular: UIFont?
    var themeFontTwentyFourSizeRegular: UIFont?
    var themeFontTwentyFiveSizeRegular: UIFont?
    var themeFontTwentySixSizeRegular: UIFont?
    var themeFontTwentySevenSizeRegular: UIFont?
    var themeFontTwentyEightSizeRegular: UIFont?
    var themeFontTwentyNineSizeRegular: UIFont?
    var themeFontThirtySizeRegular: UIFont?
    var themeFontThirtyOneSizeRegular: UIFont?
    var themeFontThirtyTwoSizeRegular: UIFont?
    var themeFontThirtyThreeSizeRegular: UIFont?
    var themeFontThirtyFourSizeRegular: UIFont?
    var themeFontThirtyFiveSizeRegular: UIFont?
    var themeFontThirtySixSizeRegular: UIFont?
    var themeFontThirtySevenSizeRegular: UIFont?
    var themeFontThirtyEightSizeRegular: UIFont?
    var themeFontThirtyNineSizeRegular: UIFont?
    var themeFontFourtySizeRegular: UIFont?
    var themeFontFourtyOneSizeRegular: UIFont?
    var themeFontFourtyTwoSizeRegular: UIFont?
    var themeFontFourtyThreeSizeRegular: UIFont?
    var themeFontFourtyFourSizeRegular: UIFont?
    var themeFontFourtyFiveSizeRegular: UIFont?
    var themeFontFourtySixSizeRegular: UIFont?
    var themeFontFourtySevenSizeRegular: UIFont?
    var themeFontFourtyEightSizeRegular: UIFont?
    
    //========================= THEME LIGHT FONTS SETTING ================//
    var themeFontFourSizeLight: UIFont?
    var themeFontFiveSizeLight: UIFont?
    var themeFontSixSizeLight: UIFont?
    var themeFontSevenSizeLight: UIFont?
    var themeFontEightSizeLight: UIFont?
    var themeFontNineSizeLight: UIFont?
    var themeFontTenSizeLight: UIFont?
    var themeFontElevenSizeLight: UIFont?
    var themeFontTwelveSizeLight: UIFont?
    var themeFontThirteenSizeLight: UIFont?
    var themeFontFourteenSizeLight: UIFont?
    var themeFontFifteenSizeLight: UIFont?
    var themeFontSixteenSizeLight: UIFont?
    var themeFontSeventeenSizeLight: UIFont?
    var themeFontEighteenSizeLight: UIFont?
    var themeFontNineteenSizeLight: UIFont?
    var themeFontTwentySizeLight: UIFont?
    var themeFontTwentyOneSizeLight: UIFont?
    var themeFontTwentyTwoSizeLight: UIFont?
    var themeFontTwentyThreeSizeLight: UIFont?
    var themeFontTwentyFourSizeLight: UIFont?
    var themeFontTwentyFiveSizeLight: UIFont?
    var themeFontTwentySixSizeLight: UIFont?
    var themeFontTwentySevenSizeLight: UIFont?
    var themeFontTwentyEightSizeLight: UIFont?
    var themeFontTwentyNineSizeLight: UIFont?
    var themeFontThirtySizeLight: UIFont?
    var themeFontThirtyOneSizeLight: UIFont?
    var themeFontThirtyTwoSizeLight: UIFont?
    var themeFontThirtyThreeSizeLight: UIFont?
    var themeFontThirtyFourSizeLight: UIFont?
    var themeFontThirtyFiveSizeLight: UIFont?
    var themeFontThirtySixSizeLight: UIFont?
    var themeFontThirtySevenSizeLight: UIFont?
    var themeFontThirtyEightSizeLight: UIFont?
    var themeFontThirtyNineSizeLight: UIFont?
    var themeFontFourtySizeLight: UIFont?
    var themeFontFourtyOneSizeLight: UIFont?
    var themeFontFourtyTwoSizeLight: UIFont?
    var themeFontFourtyThreeSizeLight: UIFont?
    var themeFontFourtyFourSizeLight: UIFont?
    var themeFontFourtyFiveSizeLight: UIFont?
    var themeFontFourtySixSizeLight: UIFont?
    var themeFontFourtySevenSizeLight: UIFont?
    var themeFontFourtyEightSizeLight: UIFont?
    
    //========================= THEME MEDIUM FONTS SETTING ================//
    var themeFontFourSizeMedium: UIFont?
    var themeFontFiveSizeMedium: UIFont?
    var themeFontSixSizeMedium: UIFont?
    var themeFontSevenSizeMedium: UIFont?
    var themeFontEightSizeMedium: UIFont?
    var themeFontNineSizeMedium: UIFont?
    var themeFontTenSizeMedium: UIFont?
    var themeFontElevenSizeMedium: UIFont?
    var themeFontTwelveSizeMedium: UIFont?
    var themeFontThirteenSizeMedium: UIFont?
    var themeFontFourteenSizeMedium: UIFont?
    var themeFontFifteenSizeMedium: UIFont?
    var themeFontSixteenSizeMedium: UIFont?
    var themeFontSeventeenSizeMedium: UIFont?
    var themeFontEighteenSizeMedium: UIFont?
    var themeFontNineteenSizeMedium: UIFont?
    var themeFontTwentySizeMedium: UIFont?
    var themeFontTwentyOneSizeMedium: UIFont?
    var themeFontTwentyTwoSizeMedium: UIFont?
    var themeFontTwentyThreeSizeMedium: UIFont?
    var themeFontTwentyFourSizeMedium: UIFont?
    var themeFontTwentyFiveSizeMedium: UIFont?
    var themeFontTwentySixSizeMedium: UIFont?
    var themeFontTwentySevenSizeMedium: UIFont?
    var themeFontTwentyEightSizeMedium: UIFont?
    var themeFontTwentyNineSizeMedium: UIFont?
    var themeFontThirtySizeMedium: UIFont?
    var themeFontThirtyOneSizeMedium: UIFont?
    var themeFontThirtyTwoSizeMedium: UIFont?
    var themeFontThirtyThreeSizeMedium: UIFont?
    var themeFontThirtyFourSizeMedium: UIFont?
    var themeFontThirtyFiveSizeMedium: UIFont?
    var themeFontThirtySixSizeMedium: UIFont?
    var themeFontThirtySevenSizeMedium: UIFont?
    var themeFontThirtyEightSizeMedium: UIFont?
    var themeFontThirtyNineSizeMedium: UIFont?
    var themeFontFourtySizeMedium: UIFont?
    var themeFontFourtyOneSizeMedium: UIFont?
    var themeFontFourtyTwoSizeMedium: UIFont?
    var themeFontFourtyThreeSizeMedium: UIFont?
    var themeFontFourtyFourSizeMedium: UIFont?
    var themeFontFourtyFiveSizeMedium: UIFont?
    var themeFontFourtySixSizeMedium: UIFont?
    var themeFontFourtySevenSizeMedium: UIFont?
    var themeFontFourtyEightSizeMedium: UIFont?
    
    //========================= THEME BOLD FONTS SETTING ================//
    var themeFontFourSizeBold: UIFont?
    var themeFontFiveSizeBold: UIFont?
    var themeFontSixSizeBold: UIFont?
    var themeFontSevenSizeBold: UIFont?
    var themeFontEightSizeBold: UIFont?
    var themeFontNineSizeBold: UIFont?
    var themeFontTenSizeBold: UIFont?
    var themeFontElevenSizeBold: UIFont?
    var themeFontTwelveSizeBold: UIFont?
    var themeFontThirteenSizeBold: UIFont?
    var themeFontFourteenSizeBold: UIFont?
    var themeFontFifteenSizeBold: UIFont?
    var themeFontSixteenSizeBold: UIFont?
    var themeFontSeventeenSizeBold: UIFont?
    var themeFontEighteenSizeBold: UIFont?
    var themeFontNineteenSizeBold: UIFont?
    var themeFontTwentySizeBold: UIFont?
    var themeFontTwentyOneSizeBold: UIFont?
    var themeFontTwentyTwoSizeBold: UIFont?
    var themeFontTwentyThreeSizeBold: UIFont?
    var themeFontTwentyFourSizeBold: UIFont?
    var themeFontTwentyFiveSizeBold: UIFont?
    var themeFontTwentySixSizeBold: UIFont?
    var themeFontTwentySevenSizeBold: UIFont?
    var themeFontTwentyEightSizeBold: UIFont?
    var themeFontTwentyNineSizeBold: UIFont?
    var themeFontThirtySizeBold: UIFont?
    var themeFontThirtyOneSizeBold: UIFont?
    var themeFontThirtyTwoSizeBold: UIFont?
    var themeFontThirtyThreeSizeBold: UIFont?
    var themeFontThirtyFourSizeBold: UIFont?
    var themeFontThirtyFiveSizeBold: UIFont?
    var themeFontThirtySixSizeBold: UIFont?
    var themeFontThirtySevenSizeBold: UIFont?
    var themeFontThirtyEightSizeBold: UIFont?
    var themeFontThirtyNineSizeBold: UIFont?
    var themeFontFourtySizeBold: UIFont?
    var themeFontFourtyOneSizeBold: UIFont?
    var themeFontFourtyTwoSizeBold: UIFont?
    var themeFontFourtyThreeSizeBold: UIFont?
    var themeFontFourtyFourSizeBold: UIFont?
    var themeFontFourtyFiveSizeBold: UIFont?
    var themeFontFourtySixSizeBold: UIFont?
    var themeFontFourtySevenSizeBold: UIFont?
    var themeFontFourtyEightSizeBold: UIFont?
    
    //========================= ALERT VIEW SETTINGS ================//
    var alertViewTitleFont: UIFont?
    var alertViewMessageFont: UIFont?
    var alertViewButtonTitleFont: UIFont?
    var alertViewCancelButtonTitleFont: UIFont?
    
    var alertViewTitleColor: UIColor?
    var alertViewContentColor: UIColor?
    var alertViewLeftButtonFontColor: UIColor?
    var alertViewBackGroundColor: UIColor?
    var alertViewLeftButtonBackgroundColor: UIColor?
    var alertViewRightButtonBackgroundColor: UIColor?
    
    //========================= OTHER CUSTOM METHODS ================//
    
    class func sharedManager() -> MySingleton
    {
        return _sharedManager
    }
    
    override init()
    {
        screenRect = UIScreen.main.bounds
        screenWidth = screenRect.width
        screenHeight = screenRect.height
        
        //========================= APPLICATION SPECIFIC SETTINGS ================//
        
        //========================= SIDE MENU SETTINGS ================//
        
        selectedScreenIndex = 0;
        
        floatLeftSideMenuWidth = (screenWidth/10) * 8
        floatRightSideMenuWidth = (screenWidth/10) * 8
        
        leftViewPresentationStyle = LGSideMenuPresentationStyle.slideAbove//slideBelow
        rightViewPresentationStyle = LGSideMenuPresentationStyle.slideAbove//scaleFromBig
        
        //========================= NAVIGATION BAR SETTINGS ================/
        navigationBarBackgroundColor = UIColor(rgb: 0x1A1A3A)
        navigationBarTitleColor = UIColor(rgb: 0xFFFFFF)
        
        if screenWidth == 320
        {
            navigationBarTitleFont = UIFont(name: "Poppins-Bold", size: 16.0)
            navigationBarTitleSmallFont = UIFont(name: "Poppins-Bold", size: 14.0)
        }
        else if screenWidth == 375
        {
            navigationBarTitleFont = UIFont(name: "Poppins-Bold", size: 17.0)
            navigationBarTitleSmallFont = UIFont(name: "Poppins-Bold", size: 14.0)
        }
        else
        {
            navigationBarTitleFont = UIFont(name: "Poppins-Bold", size: 18.0)
            navigationBarTitleSmallFont = UIFont(name: "Poppins-Bold", size: 14.0)
        }
        
        //========================= TAB BAR SETTINGS ================//
        tabBarBackgroundColor = UIColor(rgb: 0x000000)
        tabBarTitleColor = UIColor(rgb: 0xFFFFFF)
        
        if screenWidth == 320
        {
            tabTitleFont = UIFont(name: "Poppins-Bold", size: 12.0)
        }
        else if screenWidth == 375
        {
            tabTitleFont = UIFont(name: "Poppins-Bold", size: 13.0)
        }
        else
        {
            tabTitleFont = UIFont(name: "Poppins-Bold", size: 14.0)
        }
        
        //========================= THEME GLOBAL COLORS SETTINGS ================//
        themeGlobalBackgroundGreyColor = UIColor(rgb: 0xEAEAEA)

        themeGlobalPurpleColor = UIColor(rgb: 0x1A1A3A)
        themeGlobalLightPurpleColor = UIColor(rgb: 0x29294E)
        themeGlobalYellowColor = UIColor(rgb: 0xD4B144)
        themeGlobalBlueColor = UIColor(rgb: 0x28689e)
        themeGlobalGreenColor = UIColor(rgb: 0x64AA4A)
        themeGlobalLightGreenColor = UIColor(rgb: 0x35A13D)
        themeGlobalRedColor = UIColor(rgb: 0xA01A1F)
        themeGlobalWhiteColor = UIColor(rgb: 0xFFFFFF)
        themeGlobalBlackColor = UIColor(rgb: 0x000000)
        themeGlobalDarkGreyColor = UIColor(rgb: 0x5E5E5E)
        themeGlobalLightGreyColor = UIColor(rgb: 0xefefef)
        themeGlobalLightestGreyColor = UIColor(rgb: 0xF2F2F2)
        themeGlobalSeperatorGreyColor = UIColor(rgb: 0xDCDCDC)
        themeGlobalSideMenuSeperatorColor = UIColor(rgb: 0x868686)
        
        textfieldPlaceholderColor = UIColor(rgb: 0xFFFFFF).withAlphaComponent(0.7)
        textfieldTextColor = UIColor(rgb: 0xFFFFFF)
        textfieldRedTextColor = UIColor(rgb: 0xA01A1F)
        textfieldDisabledTextColor = UIColor(rgb: 0x868686)
        textfieldFloatingLabelTextColor = UIColor(rgb: 0xFFFFFF)
        textfieldBottomSeparatorColor = UIColor(rgb: 0xFFFFFF)
        
        textfieldPlaceholderLoginColor = UIColor(rgb: 0xFFFFFF).withAlphaComponent(0.5)
        textfieldTextLoginColor = UIColor(rgb: 0xFFFFFF)
        
        //========================= THEME GLOBAL CUSTOM COLORS SETTINGS ================//
        themeGlobalOrangeColor = UIColor(rgb: 0xF2530D)
        themeGlobalFacebookColor = UIColor(rgb: 0x3b5998)
        themeGlobalGoogleColor = UIColor(rgb: 0xdb3236)
        
        //========================= FLOAT VALUES SETTINGS ================//
        floatButtonCornerRadius = 10.0
        
        //========================= THEME REGULAR FONTS SETTING ================//
        themeFontFourSizeRegular = UIFont(name: "Poppins-Medium", size: 4.0)
        themeFontFiveSizeRegular = UIFont(name: "Poppins-Medium", size: 5.0)
        themeFontSixSizeRegular = UIFont(name: "Poppins-Medium", size: 6.0)
        themeFontSevenSizeRegular = UIFont(name: "Poppins-Medium", size: 7.0)
        themeFontEightSizeRegular = UIFont(name: "Poppins-Medium", size: 8.0)
        themeFontNineSizeRegular = UIFont(name: "Poppins-Medium", size: 9.0)
        themeFontTenSizeRegular = UIFont(name: "Poppins-Medium", size: 10.0)
        themeFontElevenSizeRegular = UIFont(name: "Poppins-Medium", size: 11.0)
        themeFontTwelveSizeRegular = UIFont(name: "Poppins-Medium", size: 12.0)
        themeFontThirteenSizeRegular = UIFont(name: "Poppins-Medium", size: 13.0)
        themeFontFourteenSizeRegular = UIFont(name: "Poppins-Medium", size: 14.0)
        themeFontFifteenSizeRegular = UIFont(name: "Poppins-Medium", size: 15.0)
        themeFontSixteenSizeRegular = UIFont(name: "Poppins-Medium", size: 16.0)
        themeFontSeventeenSizeRegular = UIFont(name: "Poppins-Medium", size: 17.0)
        themeFontEighteenSizeRegular = UIFont(name: "Poppins-Medium", size: 18.0)
        themeFontNineteenSizeRegular = UIFont(name: "Poppins-Medium", size: 19.0)
        themeFontTwentySizeRegular = UIFont(name: "Poppins-Medium", size: 20.0)
        themeFontTwentyOneSizeRegular = UIFont(name: "Poppins-Medium", size: 21.0)
        themeFontTwentyTwoSizeRegular = UIFont(name: "Poppins-Medium", size: 22.0)
        themeFontTwentyThreeSizeRegular = UIFont(name: "Poppins-Medium", size: 23.0)
        themeFontTwentyFourSizeRegular = UIFont(name: "Poppins-Medium", size: 24.0)
        themeFontTwentyFiveSizeRegular = UIFont(name: "Poppins-Medium", size: 25.0)
        themeFontTwentySixSizeRegular = UIFont(name: "Poppins-Medium", size: 26.0)
        themeFontTwentySevenSizeRegular = UIFont(name: "Poppins-Medium", size: 27.0)
        themeFontTwentyEightSizeRegular = UIFont(name: "Poppins-Medium", size: 28.0)
        themeFontTwentyNineSizeRegular = UIFont(name: "Poppins-Medium", size: 29.0)
        themeFontThirtySizeRegular = UIFont(name: "Poppins-Medium", size: 30.0)
        themeFontThirtyOneSizeRegular = UIFont(name: "Poppins-Medium", size: 31.0)
        themeFontThirtyTwoSizeRegular = UIFont(name: "Poppins-Medium", size: 32.0)
        themeFontThirtyThreeSizeRegular = UIFont(name: "Poppins-Medium", size: 33.0)
        themeFontThirtyFourSizeRegular = UIFont(name: "Poppins-Medium", size: 34.0)
        themeFontThirtyFiveSizeRegular = UIFont(name: "Poppins-Medium", size: 35.0)
        themeFontThirtySixSizeRegular = UIFont(name: "Poppins-Medium", size: 36.0)
        themeFontThirtySevenSizeRegular = UIFont(name: "Poppins-Medium", size: 37.0)
        themeFontThirtyEightSizeRegular = UIFont(name: "Poppins-Medium", size: 38.0)
        themeFontThirtyNineSizeRegular = UIFont(name: "Poppins-Medium", size: 39.0)
        themeFontFourtySizeRegular = UIFont(name: "Poppins-Medium", size: 40.0)
        themeFontFourtyOneSizeRegular = UIFont(name: "Poppins-Medium", size: 41.0)
        themeFontFourtyTwoSizeRegular = UIFont(name: "Poppins-Medium", size: 42.0)
        themeFontFourtyThreeSizeRegular = UIFont(name: "Poppins-Medium", size: 43.0)
        themeFontFourtyFourSizeRegular = UIFont(name: "Poppins-Medium", size: 44.0)
        themeFontFourtyFiveSizeRegular = UIFont(name: "Poppins-Medium", size: 45.0)
        themeFontFourtySixSizeRegular = UIFont(name: "Poppins-Medium", size: 46.0)
        themeFontFourtySevenSizeRegular = UIFont(name: "Poppins-Medium", size: 47.0)
        themeFontFourtyEightSizeRegular = UIFont(name: "Poppins-Medium", size: 48.0)
        
        //========================= THEME LIGHT FONTS SETTING ================//
        themeFontFourSizeLight = UIFont(name: "Poppins-Light", size: 4.0)
        themeFontFiveSizeLight = UIFont(name: "Poppins-Light", size: 5.0)
        themeFontSixSizeLight = UIFont(name: "Poppins-Light", size: 6.0)
        themeFontSevenSizeLight = UIFont(name: "Poppins-Light", size: 7.0)
        themeFontEightSizeLight = UIFont(name: "Poppins-Light", size: 8.0)
        themeFontNineSizeLight = UIFont(name: "Poppins-Light", size: 9.0)
        themeFontTenSizeLight = UIFont(name: "Poppins-Light", size: 10.0)
        themeFontElevenSizeLight = UIFont(name: "Poppins-Light", size: 11.0)
        themeFontTwelveSizeLight = UIFont(name: "Poppins-Light", size: 12.0)
        themeFontThirteenSizeLight = UIFont(name: "Poppins-Light", size: 13.0)
        themeFontFourteenSizeLight = UIFont(name: "Poppins-Light", size: 14.0)
        themeFontFifteenSizeLight = UIFont(name: "Poppins-Light", size: 15.0)
        themeFontSixteenSizeLight = UIFont(name: "Poppins-Light", size: 16.0)
        themeFontSeventeenSizeLight = UIFont(name: "Poppins-Light", size: 17.0)
        themeFontEighteenSizeLight = UIFont(name: "Poppins-Light", size: 18.0)
        themeFontNineteenSizeLight = UIFont(name: "Poppins-Light", size: 19.0)
        themeFontTwentySizeLight = UIFont(name: "Poppins-Light", size: 20.0)
        themeFontTwentyOneSizeLight = UIFont(name: "Poppins-Light", size: 21.0)
        themeFontTwentyTwoSizeLight = UIFont(name: "Poppins-Light", size: 22.0)
        themeFontTwentyThreeSizeLight = UIFont(name: "Poppins-Light", size: 23.0)
        themeFontTwentyFourSizeLight = UIFont(name: "Poppins-Light", size: 24.0)
        themeFontTwentyFiveSizeLight = UIFont(name: "Poppins-Light", size: 25.0)
        themeFontTwentySixSizeLight = UIFont(name: "Poppins-Light", size: 26.0)
        themeFontTwentySevenSizeLight = UIFont(name: "Poppins-Light", size: 27.0)
        themeFontTwentyEightSizeLight = UIFont(name: "Poppins-Light", size: 28.0)
        themeFontTwentyNineSizeLight = UIFont(name: "Poppins-Light", size: 29.0)
        themeFontThirtySizeLight = UIFont(name: "Poppins-Light", size: 30.0)
        themeFontThirtyOneSizeLight = UIFont(name: "Poppins-Light", size: 31.0)
        themeFontThirtyTwoSizeLight = UIFont(name: "Poppins-Light", size: 32.0)
        themeFontThirtyThreeSizeLight = UIFont(name: "Poppins-Light", size: 33.0)
        themeFontThirtyFourSizeLight = UIFont(name: "Poppins-Light", size: 34.0)
        themeFontThirtyFiveSizeLight = UIFont(name: "Poppins-Light", size: 35.0)
        themeFontThirtySixSizeLight = UIFont(name: "Poppins-Light", size: 36.0)
        themeFontThirtySevenSizeLight = UIFont(name: "Poppins-Light", size: 37.0)
        themeFontThirtyEightSizeLight = UIFont(name: "Poppins-Light", size: 38.0)
        themeFontThirtyNineSizeLight = UIFont(name: "Poppins-Light", size: 39.0)
        themeFontFourtySizeLight = UIFont(name: "Poppins-Light", size: 40.0)
        themeFontFourtyOneSizeLight = UIFont(name: "Poppins-Light", size: 41.0)
        themeFontFourtyTwoSizeLight = UIFont(name: "Poppins-Light", size: 42.0)
        themeFontFourtyThreeSizeLight = UIFont(name: "Poppins-Light", size: 43.0)
        themeFontFourtyFourSizeLight = UIFont(name: "Poppins-Light", size: 44.0)
        themeFontFourtyFiveSizeLight = UIFont(name: "Poppins-Light", size: 45.0)
        themeFontFourtySixSizeLight = UIFont(name: "Poppins-Light", size: 46.0)
        themeFontFourtySevenSizeLight = UIFont(name: "Poppins-Light", size: 47.0)
        themeFontFourtyEightSizeLight = UIFont(name: "Poppins-Light", size: 48.0)
        
        //========================= THEME MEDIUM FONTS SETTING ================//
        themeFontFourSizeMedium = UIFont(name: "Poppins-SemiBold", size: 4.0)
        themeFontFiveSizeMedium = UIFont(name: "Poppins-SemiBold", size: 5.0)
        themeFontSixSizeMedium = UIFont(name: "Poppins-SemiBold", size: 6.0)
        themeFontSevenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 7.0)
        themeFontEightSizeMedium = UIFont(name: "Poppins-SemiBold", size: 8.0)
        themeFontNineSizeMedium = UIFont(name: "Poppins-SemiBold", size: 9.0)
        themeFontTenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 10.0)
        themeFontElevenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 11.0)
        themeFontTwelveSizeMedium = UIFont(name: "Poppins-SemiBold", size: 12.0)
        themeFontThirteenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 13.0)
        themeFontFourteenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 14.0)
        themeFontFifteenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 15.0)
        themeFontSixteenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 16.0)
        themeFontSeventeenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 17.0)
        themeFontEighteenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 18.0)
        themeFontNineteenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 19.0)
        themeFontTwentySizeMedium = UIFont(name: "Poppins-SemiBold", size: 20.0)
        themeFontTwentyOneSizeMedium = UIFont(name: "Poppins-SemiBold", size: 21.0)
        themeFontTwentyTwoSizeMedium = UIFont(name: "Poppins-SemiBold", size: 22.0)
        themeFontTwentyThreeSizeMedium = UIFont(name: "Poppins-SemiBold", size: 23.0)
        themeFontTwentyFourSizeMedium = UIFont(name: "Poppins-SemiBold", size: 24.0)
        themeFontTwentyFiveSizeMedium = UIFont(name: "Poppins-SemiBold", size: 25.0)
        themeFontTwentySixSizeMedium = UIFont(name: "Poppins-SemiBold", size: 26.0)
        themeFontTwentySevenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 27.0)
        themeFontTwentyEightSizeMedium = UIFont(name: "Poppins-SemiBold", size: 28.0)
        themeFontTwentyNineSizeMedium = UIFont(name: "Poppins-SemiBold", size: 29.0)
        themeFontThirtySizeMedium = UIFont(name: "Poppins-SemiBold", size: 30.0)
        themeFontThirtyOneSizeMedium = UIFont(name: "Poppins-SemiBold", size: 31.0)
        themeFontThirtyTwoSizeMedium = UIFont(name: "Poppins-SemiBold", size: 32.0)
        themeFontThirtyThreeSizeMedium = UIFont(name: "Poppins-SemiBold", size: 33.0)
        themeFontThirtyFourSizeMedium = UIFont(name: "Poppins-SemiBold", size: 34.0)
        themeFontThirtyFiveSizeMedium = UIFont(name: "Poppins-SemiBold", size: 35.0)
        themeFontThirtySixSizeMedium = UIFont(name: "Poppins-SemiBold", size: 36.0)
        themeFontThirtySevenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 37.0)
        themeFontThirtyEightSizeMedium = UIFont(name: "Poppins-SemiBold", size: 38.0)
        themeFontThirtyNineSizeMedium = UIFont(name: "Poppins-SemiBold", size: 39.0)
        themeFontFourtySizeMedium = UIFont(name: "Poppins-SemiBold", size: 40.0)
        themeFontFourtyOneSizeMedium = UIFont(name: "Poppins-SemiBold", size: 41.0)
        themeFontFourtyTwoSizeMedium = UIFont(name: "Poppins-SemiBold", size: 42.0)
        themeFontFourtyThreeSizeMedium = UIFont(name: "Poppins-SemiBold", size: 43.0)
        themeFontFourtyFourSizeMedium = UIFont(name: "Poppins-SemiBold", size: 44.0)
        themeFontFourtyFiveSizeMedium = UIFont(name: "Poppins-SemiBold", size: 45.0)
        themeFontFourtySixSizeMedium = UIFont(name: "Poppins-SemiBold", size: 46.0)
        themeFontFourtySevenSizeMedium = UIFont(name: "Poppins-SemiBold", size: 47.0)
        themeFontFourtyEightSizeMedium = UIFont(name: "Poppins-SemiBold", size: 48.0)
        
        //========================= THEME BOLD FONTS SETTING ================//
        themeFontFourSizeBold = UIFont(name: "Poppins-Bold", size: 4.0)
        themeFontFiveSizeBold = UIFont(name: "Poppins-Bold", size: 5.0)
        themeFontSixSizeBold = UIFont(name: "Poppins-Bold", size: 6.0)
        themeFontSevenSizeBold = UIFont(name: "Poppins-Bold", size: 7.0)
        themeFontEightSizeBold = UIFont(name: "Poppins-Bold", size: 8.0)
        themeFontNineSizeBold = UIFont(name: "Poppins-Bold", size: 9.0)
        themeFontTenSizeBold = UIFont(name: "Poppins-Bold", size: 10.0)
        themeFontElevenSizeBold = UIFont(name: "Poppins-Bold", size: 11.0)
        themeFontTwelveSizeBold = UIFont(name: "Poppins-Bold", size: 12.0)
        themeFontThirteenSizeBold = UIFont(name: "Poppins-Bold", size: 13.0)
        themeFontFourteenSizeBold = UIFont(name: "Poppins-Bold", size: 14.0)
        themeFontFifteenSizeBold = UIFont(name: "Poppins-Bold", size: 15.0)
        themeFontSixteenSizeBold = UIFont(name: "Poppins-Bold", size: 16.0)
        themeFontSeventeenSizeBold = UIFont(name: "Poppins-Bold", size: 17.0)
        themeFontEighteenSizeBold = UIFont(name: "Poppins-Bold", size: 18.0)
        themeFontNineteenSizeBold = UIFont(name: "Poppins-Bold", size: 19.0)
        themeFontTwentySizeBold = UIFont(name: "Poppins-Bold", size: 20.0)
        themeFontTwentyOneSizeBold = UIFont(name: "Poppins-Bold", size: 21.0)
        themeFontTwentyTwoSizeBold = UIFont(name: "Poppins-Bold", size: 22.0)
        themeFontTwentyThreeSizeBold = UIFont(name: "Poppins-Bold", size: 23.0)
        themeFontTwentyFourSizeBold = UIFont(name: "Poppins-Bold", size: 24.0)
        themeFontTwentyFiveSizeBold = UIFont(name: "Poppins-Bold", size: 25.0)
        themeFontTwentySixSizeBold = UIFont(name: "Poppins-Bold", size: 26.0)
        themeFontTwentySevenSizeBold = UIFont(name: "Poppins-Bold", size: 27.0)
        themeFontTwentyEightSizeBold = UIFont(name: "Poppins-Bold", size: 28.0)
        themeFontTwentyNineSizeBold = UIFont(name: "Poppins-Bold", size: 29.0)
        themeFontThirtySizeBold = UIFont(name: "Poppins-Bold", size: 30.0)
        themeFontThirtyOneSizeBold = UIFont(name: "Poppins-Bold", size: 31.0)
        themeFontThirtyTwoSizeBold = UIFont(name: "Poppins-Bold", size: 32.0)
        themeFontThirtyThreeSizeBold = UIFont(name: "Poppins-Bold", size: 33.0)
        themeFontThirtyFourSizeBold = UIFont(name: "Poppins-Bold", size: 34.0)
        themeFontThirtyFiveSizeBold = UIFont(name: "Poppins-Bold", size: 35.0)
        themeFontThirtySixSizeBold = UIFont(name: "Poppins-Bold", size: 36.0)
        themeFontThirtySevenSizeBold = UIFont(name: "Poppins-Bold", size: 37.0)
        themeFontThirtyEightSizeBold = UIFont(name: "Poppins-Bold", size: 38.0)
        themeFontThirtyNineSizeBold = UIFont(name: "Poppins-Bold", size: 39.0)
        themeFontFourtySizeBold = UIFont(name: "Poppins-Bold", size: 40.0)
        themeFontFourtyOneSizeBold = UIFont(name: "Poppins-Bold", size: 41.0)
        themeFontFourtyTwoSizeBold = UIFont(name: "Poppins-Bold", size: 42.0)
        themeFontFourtyThreeSizeBold = UIFont(name: "Poppins-Bold", size: 43.0)
        themeFontFourtyFourSizeBold = UIFont(name: "Poppins-Bold", size: 44.0)
        themeFontFourtyFiveSizeBold = UIFont(name: "Poppins-Bold", size: 45.0)
        themeFontFourtySixSizeBold = UIFont(name: "Poppins-Bold", size: 46.0)
        themeFontFourtySevenSizeBold = UIFont(name: "Poppins-Bold", size: 47.0)
        themeFontFourtyEightSizeBold = UIFont(name: "Poppins-Bold", size: 48.0)
        
        //========================= ALERT VIEW SETTINGS ================//
        alertViewTitleFont = UIFont(name: "Poppins-Bold", size: 18.0)
        alertViewMessageFont = UIFont(name: "Poppins-Medium", size: 14.0)
        alertViewButtonTitleFont = UIFont(name: "Poppins-Medium", size: 16.0)
        alertViewCancelButtonTitleFont = UIFont(name: "Poppins-SemiBold", size: 16.0)
        
        alertViewTitleColor = UIColor(rgb: 0x0092DD)
        alertViewContentColor = UIColor(rgb: 0x4a4a4a)
        alertViewLeftButtonFontColor = UIColor(rgb: 0xFFFFFF)
        alertViewBackGroundColor = UIColor(rgb: 0xFFFFFF)
        alertViewLeftButtonBackgroundColor = UIColor(rgb: 0x1A1A3A)//0x35A13D)
        alertViewRightButtonBackgroundColor = UIColor(rgb: 0x0092DD)
        
        //========================= OTHER CUSTOM METHODS ================//
        
        super.init()
    }
}

let _sharedManager: MySingleton = { MySingleton() }()

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

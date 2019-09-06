//
//  Common.swift
//  Moments-Swift
//
//  Created by 李永杰 on 2019/9/6.
//  Copyright © 2019 muheda. All rights reserved.
//
import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let isAfterX = kScreenHeight >= 812 ? true : false

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kNavigationHeight = isAfterX ? kStatusBarHeight + 44 : kStatusBarHeight + 20

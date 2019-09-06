//
//  MomentLayout.swift
//  Moments-Swift
//
//  Created by 李永杰 on 2019/9/6.
//  Copyright © 2019 muheda. All rights reserved.
//

import UIKit
import YYKit_used
class MomentLayout: NSObject {

    var stream: Stream?
    var totalHeight: CGFloat = 0
    
    convenience init(streamLayout: Stream) {
        self.init()
        stream = streamLayout
        layout()
    }
    
    func layout() {
        let headerHeight:CGFloat = 80
        let bottomHeight:CGFloat = 50
        
        var commentHeight:CGFloat = 100
        var picturesHeight:CGFloat = CGFloat((kScreenWidth - 30) / 3)
        var num:CGFloat = 0
        
        commentHeight = (stream?.content!.height(for: UIFont.systemFont(ofSize: 15), width: kScreenWidth))!
        let picNum = stream?.picUrls?.count
        if picNum! > 0 && picNum! <= 3 {
            num = 1
        }else if picNum! > 3 && picNum! <= 6{
            num = 2
        }else if picNum! > 6{
            num = 3
        }
        picturesHeight = num * picturesHeight

        self.totalHeight += headerHeight
        self.totalHeight += commentHeight
        self.totalHeight += picturesHeight
        self.totalHeight += bottomHeight
    }
}

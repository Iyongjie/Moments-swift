//
//  Moment.swift
//  Moments-Swift
//
//  Created by 李永杰 on 2019/9/6.
//  Copyright © 2019 muheda. All rights reserved.
//

import UIKit
import HandyJSON

struct Moment: HandyJSON {
    var emptyTip: String?
    var endScore: Int = 0
    var hasMore: Bool = false
    var pullTip: String?
    var startScore: Int = 0
    var streamList: [Stream]?
}

struct Stream: HandyJSON {
    var avatar : String?
    var commentsCount: Int = 0
    var content: String?
    var id: Int = 0
    var issuedTs: Int = 0
    var liked: Bool = false
    var likesCount: Int = 0
    var nickname: String?
    var picUrls: [Picurl]?
}

struct Picurl: HandyJSON {
    var originUrl: String?
    var thumbnailUrl: String?
}

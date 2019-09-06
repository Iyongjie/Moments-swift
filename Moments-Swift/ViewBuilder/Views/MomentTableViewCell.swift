//
//  MomentTableViewCell.swift
//  Moments-Swift
//
//  Created by 李永杰 on 2019/9/6.
//  Copyright © 2019 muheda. All rights reserved.
//

import UIKit
import Kingfisher

class MomentTableViewCell: UITableViewCell {
    var momentLayout: MomentLayout? {
        didSet {
            guard let layout = momentLayout else {return}
            headerView.streamModel = layout.stream
            bottomView.streamModel = layout.stream
        }
    }
    
    private var headerView: MomentHeaderView = {
        let header = MomentHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return header
    }()

    private var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    private var picCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        return collectionView
    }()
    
    private var bottomView: MomentBottomView = {
        let bottomView = MomentBottomView()
        return bottomView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(headerView)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(picCollectionView)
        self.contentView.addSubview(bottomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MomentHeaderView: UIView {
    
    var streamModel: Stream? {
        didSet {
            guard let stream = streamModel else {return}
            avatorImageView.kf.setImage(with: URL(string: stream.avatar!))
            titleLabel.text = stream.nickname!
        }
    }
    
    private var avatorImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatorImageView)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MomentBottomView: UIView {
    
    var streamModel: Stream? {
        didSet {
            guard let stream = streamModel else {return}
            dateLabel.text =  updateTimeToCurrennTime(timeStamp: Double(CGFloat(stream.issuedTs)))
        }
    }
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    private var likeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()
    private var commentButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(dateLabel)
        self.addSubview(likeButton)
        self.addSubview(commentButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - 根据后台时间戳返回几分钟前，几小时前，几天前
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        //时间差大于一小时小于24小时内
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        //时间差大于一天小于30天内
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
}

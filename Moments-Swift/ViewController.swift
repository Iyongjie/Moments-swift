//
//  ViewController.swift
//  Moments-Swift
//
//  Created by 李永杰 on 2019/9/6.
//  Copyright © 2019 muheda. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

let MomentTableCellId = "MomentTableCellId"

class ViewController: UIViewController {
    var moment: Moment?
    var layouts: [MomentLayout] = []
    
    private var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        table.register(MomentTableViewCell.self, forCellReuseIdentifier: MomentTableCellId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        configUI()
    }

    func initData() {

        let path = Bundle.main.path(forResource: "moments", ofType: "json")
        let jsonData=NSData(contentsOfFile: path!)
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<Moment>.deserializeFrom(json: json["data"].description) {
            moment = mappedObject
            for stream in moment!.streamList! {
                let layout = MomentLayout(streamLayout: stream)
                layouts.append(layout)
                tableView.reloadData()
            }
        }
    }
    
    func configUI() {
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layouts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let layout = layouts[indexPath.row]
        let cell: MomentTableViewCell = tableView.dequeueReusableCell(withIdentifier: MomentTableCellId) as! MomentTableViewCell
        cell.momentLayout = layout
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let layout = layouts[indexPath.row]
        return CGFloat(layout.totalHeight)
    }
}

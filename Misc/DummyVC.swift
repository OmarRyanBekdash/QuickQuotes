//////
//////  DummyVC.swift
//////  quote_project
//////
//////  Created by Omar Beckdash on 1/28/19.
//////  Copyright © 2019 Omar Bekdash. All rights reserved.
//////
////
//import UIKit
//class DummyVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//    var tableView:UITableView?
//    var items = NSMutableArray()
//
//    override func viewWillAppear(_ animated: Bool) {
//        let frame:CGRect = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-100)
//        self.tableView = UITableView(frame: frame)
//        self.tableView?.dataSource = self
//        self.tableView?.delegate = self
//        self.view.addSubview(self.tableView!)
//
//        let btn = UIButton(frame: CGRect(x: 0, y: 25, width: self.view.frame.width, height: 50))
//        btn.backgroundColor = UIColor.cyan
//        //btn.title = "Add new Dummy"
//        btn.setTitle("Add new Dummy", for: .normal)
//        btn.addTarget(self, action: Selector("addDummyData"), for: UIControl.Event.touchUpInside)
//        self.view.addSubview(btn)
//    }
//
//    func addDummyData() {
//        RestApiManager.sharedInstance.getPicture { json in
//            let results = json["results"]
//            for (index: String, subJSON: JSON) in results {
//                let user: AnyObject = subJSON["user"]
//                self.items.add(user)
//                DispatchQueue.main.async{
//                    self.tableView?.reloadData()
//                }
//            }
//        }
//    }
//
//}

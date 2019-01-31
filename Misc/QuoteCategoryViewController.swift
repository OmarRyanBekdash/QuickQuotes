////
////  QuoteCategoryViewController.swift
////  quote_project
////
////  Created by Omar Beckdash on 1/12/19.
////  Copyright © 2019 Omar Bekdash. All rights reserved.
////
//
//import UIKit
//
//
//
//class QuoteCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var categoryTableView: UITableView!
//    //create a table view
//    var categoryArray : [Category]!
//    let reuseIdentifier = "categoryCellReuse"
//    let cellHeight: CGFloat = 95
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "Choose your quote"
//        
//        view.backgroundColor = .white
//
//        
//        categoryArray = [
//            Category(cellTitle: "Inspiring Quote of the day", id: "inspire"),
//            Category( cellTitle: "Management Quote of the day",id: "management"),
//            Category(cellTitle: "Sports Quote of the day", id: "sports"),
//            Category(cellTitle: "Quote of the day about life", id: "life"),
//            Category(cellTitle: "Funny Quote of the day", id: "funny"),
//            Category(cellTitle: "Quote of the day about Love", id: "love"),
//            Category(cellTitle: "Art quote of the day", id: "art"),
//            Category(cellTitle: "Quote of the day for students", id: "students")
//        ]
//        
//
//        
//        // Initialize categoryTableView
//        categoryTableView = UITableView(frame: .zero)
//        categoryTableView.translatesAutoresizingMaskIntoConstraints = false
//        categoryTableView.delegate = self
//        categoryTableView.dataSource = self
//        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
//        categoryTableView.tableFooterView = UIView()
//        view.addSubview(categoryTableView)
//        
//        
//        
//        
//        setupConstraints()
//    }
//    
//    func setupConstraints() {
//        // Setup the constraints for our views
//       
//        NSLayoutConstraint.activate([
//            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            categoryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            categoryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
//            ])
//    
//    
//    //    @objc func pushNavViewController() {
//    //        let navViewController = AddSongViewController()
//    //        navViewController.delegate = self
//    //        navigationController?.pushViewController(navViewController, animated: true)
//    //    }
//    }
//    
//    
//    // MARK: - UITableViewDataSource methods
//    //1. cellForRowAt
//    func tableView(_ categoryTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = categoryTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CategoryTableViewCell
//        let category = categoryArray[indexPath.row]
//        cell.configure(for: category.cellTitle)
//        cell.setNeedsUpdateConstraints()
//        //cell.selectionStyle = .none
//        return cell
//    }
//    
//    
//    //2. numOfRowsinSec
//    func tableView(_ categoryTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categoryArray.count
//    }
//    
//    //3. Hieght for row at
//    func tableView(_ categoryTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return cellHeight
//
//    }
//    
//    //didSelectRowAt
//    func tableView(_ categoryTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
////OLD METHOD
//        let quoteViewController = QuoteViewController()
//        let category = categoryArray[indexPath.row]
//        quoteViewController.determineCategory(categoryParameter: category.id, quoteViewController: quoteViewController)
//        self.navigationController?.pushViewController(quoteViewController, animated: true)
//        
////        let quoteTableViewController = QuoteTableViewController()
////        self.navigationController?.pushViewController(quoteTableViewController, animated: true)
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

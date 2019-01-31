////
////  SavedQuotesViewController.swift
////  quote_project
////
////  Created by Omar Beckdash on 1/12/19.
////  Copyright © 2019 Omar Bekdash. All rights reserved.
////
//
//import UIKit
//
//class SavedQuotesViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {
//
//    var tableView = UITableView()
//    let quoteCellIdentifier = "QuoteCell"
//    var searchController: UISearchController!
//
//    // MARK: Search var
//    let searchBy: SearchType = .title // TODO: You change this to search by titles or ingredients
//
//    // MARK: Model var
//
//    var recipes: [Recipe] = []
//
//    // MARK: View Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Set navigation bar title
//        title = "Recipes"
//
//        // Layout views
//        view.addSubview(tableView)
//
//        // Pin the tableview’s anchors to its superview
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        // Set up tableview logic
//        tableView.dataSource = self
//        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: quoteCellIdentifier)
//
//        // Make tableview cells' height dynamically resize
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableView.automaticDimension
//
//        // Set up search controller logic
//
//        // Initializing with searchResultsController set to nil means that
//        // searchController will use this view controller to display the search results
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//
//        // If we are using this same view controller to present the results
//        // dimming it out wouldn't make sense. Should probably only set
//        // this to yes if using another controller to display the search results.
//        searchController.dimsBackgroundDuringPresentation = false
//
//        searchController.searchBar.placeholder = searchBy == .title ? "Search by title": "Search by ingredients (deliminate \" \")"
//        searchController.searchBar.sizeToFit()
//        tableView.tableHeaderView = searchController.searchBar
//
//        // Sets this view controller as presenting view controller for the search interface
//        definesPresentationContext = true
//    }
//
//    // MARK: UITableView Data Source
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: quoteCellIdentifier, for: indexPath) as! RecipeTableViewCell
//
//        cell.titleLabel.text = recipes[indexPath.row].title
//
//        cell.detailLabel.text = "Ingredients: \(recipes[indexPath.row].ingredients)"
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return recipes.count
//    }
//
//    // MARK: UISearchResultsUpdating Protocol
//
//    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            if !searchText.isEmpty {
//                switch searchBy {
//
//                    /// ***
//                    /// NOTE: You can set searchBy to be .title or .ingredients at the top of this class
//                /// ***
//                case .title:
//                    // TODO: Make a request to the Recipe Puppy API using a
//                    // title and then update the table view with the updated [Recipe]
//                    // that you get after you decode the response
//                    // Hint: The searchText is the title.
//
//                    //let array = searchText.components(separatedBy: " ")
//
//                    NetworkManager.getRecipe(fromTitle: searchText) { (recipesArray) in
//                        self.recipes = recipesArray //update tableview
//                    }
//
//                    DispatchQueue.main.async{
//                        self.tableView.reloadData()
//                    }
//
//
//                    print("search by title")
//
//                    //manually do it
//
//                case .ingredients:
//                    // TODO: Make a request to the Recipe Puppy API using a list of
//                    // ingredients and then update the table view with the updated [Recipe]
//                    // that you get after you decode the response
//                    // Hint: The searchText is a string where the ingredients are
//                    // separated by commas. (i.e. Apple, Butter, Cream)
//                    let array = searchText.components(separatedBy: " ")
//
//                    NetworkManager.getRecipe(fromIngredients: array) { (recipesArray) in
//                        self.recipes = recipesArray //update tableview
//                    }
//
//                    DispatchQueue.main.async{
//                        self.tableView.reloadData()
//                    }
//
//
//
//                    print("search by ingredients")
//                }
//            }
//            else {
//                self.recipes = []
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//}

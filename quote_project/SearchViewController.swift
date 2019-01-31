//
//  SearchViewController.swift
//  quote_project
//
//  Created by Omar Bekdash on 1/10/19.
//  Copyright © 2018 CS 1998. All rights reserved.
//

import UIKit

//protocol SaveQuoteDelegate: class {
//    func storeQuoteObject(quoteObject: Quote)
//}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    var savedQuotesTableView = UITableView()
    let reuseIdentifier = "reuseIdentifier"
    var searchController: UISearchController!
//    static var pathOfQuoteData = Bundle.main.url(forResource: "quote_objects", withExtension: "json")
    
    static var pathOfQuoteData = URL(string: "/Users/theB/Library/Developer/CoreSimulator/Devices/E153BCDD-B62B-4964-B006-9D17A1014E33/data/Containers/Data/Application/E8C3EFCD-4B8C-4E85-B0C2-096C2DA06EC2/Documents/save_data.json")
    // MARK: Search var
    //let : SearchType = .title // TODO: You change this to search by titles or ingredients
    
    // MARK: Model var
    
     //for delineating a saved quote object
    var filterArray = [Quote]()  // for filtering out an array
    // MARK: View Lifecycle
    static var topLevel: [AnyObject] = []
    static var tempSaved: [Quote] = []
    static var jsonArray: [Quote] = []
    
    
    //@IBAction func saveArray(_ sender: )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set navigation bar title
        title = "Saved Quotes"
        
        // Layout views
        self.accessSavedQuoteData()
        view.addSubview(savedQuotesTableView)
        // Pin the tableview’s anchors to its superview
        savedQuotesTableView.translatesAutoresizingMaskIntoConstraints = false
        savedQuotesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        savedQuotesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        savedQuotesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        savedQuotesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // Set up tableview logic
        savedQuotesTableView.delegate = self
        savedQuotesTableView.dataSource = self
        savedQuotesTableView.tableFooterView = UIView()
        savedQuotesTableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // Make tableview cells' height dynamically resize
        savedQuotesTableView.estimatedRowHeight = 100
        savedQuotesTableView.rowHeight = UITableView.automaticDimension
        
        // Set up search controller logic
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search by author or tag keywords"
        searchController.searchBar.sizeToFit()
        savedQuotesTableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Library", style: .plain, target: self, action: #selector(buttonTapped))
    }
    
 
    //THIS IS INEFFICIENT YEAH? APPDELEGATE WOULD BE BETTER
    func accessSavedQuoteData(){
    
        //if(SearchViewController.pathOfQuoteData == nil){ return}

        SearchViewController.tempSaved.removeAll()
        SearchViewController.topLevel.removeAll()
        

        let fileManager = FileManager.default
        let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let jsonUrl = url.appendingPathComponent("save_data.json")
        //SearchViewController.pathOfQuoteData = jsonUrl
        let jsonReadData = try! NSData(contentsOf: jsonUrl)
        //var objects: [Quote] = []
        //Maybe nothing is yet added to the json, so the whole thing is blank wich is why it is blanking (see top)
        if let jsonReadData = jsonReadData{
            let parsedQuotes = try! JSONSerialization.jsonObject(with: jsonReadData as Data, options: .mutableContainers)
            let temp = parsedQuotes as! [[String:AnyObject]]
            
            //print(temp)

            for quote in temp{
                
                guard let quoteQuote = quote["quote"] as? String else {continue}
                guard let quoteAuthor = quote["author"] as? String else {continue}
                guard let quoteDate = quote["date"] as? String else {continue}
                guard let quoteTags = quote["tags"] as? [String] else {continue}
                guard let quoteCategory = quote["category"] as? String else {continue}
                
                let newQuote = Quote.init(quote: quoteQuote, author: quoteAuthor, length: "", tags: quoteTags, category: quoteCategory, title: "", date: quoteDate, permalink: "", id: "", background: "")
                SearchViewController.tempSaved.append(newQuote)
                //SearchViewController.topLevel.append(newQuote as AnyObject)
            }
            
            for quoteObject in SearchViewController.tempSaved {
                var quoteDict: [String : AnyObject] = [:]
                quoteDict["quote"] = quoteObject.quote as AnyObject
                quoteDict["author"] = quoteObject.author as AnyObject
                quoteDict["category"] = quoteObject.category as AnyObject
                quoteDict["tags"] = quoteObject.tags as AnyObject
                quoteDict["date"] = quoteObject.date as AnyObject
                //APPEND TO TOPLEVEL, WHICH IS THE DATA-STORING ARRAY
                SearchViewController.topLevel.append(quoteDict as AnyObject)
            }
            
        }
        
    }
    
//    func saveContext () {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        if context.hasChanges {
//            do{
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        //There are Three cases
        
        //search bar is unfilled:
        //searchable array is set to the static array of all saved quotes
        if searchBarIsUnfilled(){
            filterArray = SearchViewController.tempSaved //previously savedQuotesArray
            savedQuotesTableView.reloadData()
        }
        //search bar is **NOT** unfilled, so user is typing:
        //searchable array gets filtered
        else if !searchBarIsUnfilled() {
            last = true
            filterSearchInput(searchController.searchBar.text!)
            savedQuotesTableView.reloadData()
        }
        //If the static array of all saved quotes is empty
        //then the searchable array is obviously empty too
        else if SearchViewController.tempSaved.isEmpty {
            self.filterArray = []
            savedQuotesTableView.reloadData()
        }
        else if filterArray.isEmpty && !searchBarIsUnfilled(){
            //filterSearchInput(searchController.searchBar.text!)
            savedQuotesTableView.reloadData()
        }
        

    }
    
    // MARK: UISearchResultsUpdating Protocol
    func searchBarIsUnfilled()-> Bool{
        return searchController.searchBar.text?.isEmpty ?? true //if nil, then defaults to true
    }
    
    func filterSearchInput(_ searchText: String, scope: String = "All"){
        //closure function for filtering array. If element at given index of array satisfies requirements,
        //then it is filtered through.
        //if author/category string or the tags array contains the searchText, it filters through
        filterArray = SearchViewController.tempSaved.filter({ (quote : Quote) -> Bool in
            return quote.author.lowercased().contains(searchText.lowercased()) ||
                quote.category.lowercased().contains(searchText.lowercased()) ||
                quote.tags.contains(searchText.lowercased())
        })
    }
    
    
    //--------------------------------------------------------------------
    //--------------------------------------------------------------------
    //--------------------------------------------------------------------
    // MARK: UITableView Data Source

    
    
//    override func viewWillAppear(_ animated: Bool) {
//        getData()
//        savedQuotesTableView!.reloadData()
//    }
    
    func tableView(_ savedQuotesTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        //self.savedQuotesTableView.reloadData()
        //filter array and global array both empty
        if filterArray.isEmpty && SearchViewController.tempSaved.isEmpty{
            print("EMPTY FILTER ARRAY and GLOBAL")
            print(SearchViewController.tempSaved.count)
            return /*SearchViewController.savedQuotesArray.count*/ SearchViewController.tempSaved.count
        }
        
//        else if filterArray.isEmpty {
//            print("empty filter and not empty global")
//            print(SearchViewController.tempSaved.count)
//
//
//            return SearchViewController.tempSaved.count
//
//        }

        //filter array empty but global array containing objects
            //return count of global array
            //filter array empty, global array full
        else if last == false && filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
            print("empty filter and not empty global")
            print(SearchViewController.tempSaved.count)
            
           
            return SearchViewController.tempSaved.count
            
        }

        //If filter array containing objects (implies global array not empty)
        else if !filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
            print("filter array not empty, global not empty")
            print(filterArray.count)
            return filterArray.count
        }
//        else if filterArray.isEmpty && !searchBarIsUnfilled() && !SearchViewController.tempSaved.isEmpty {
//            print("filter empty, searchbar not empty, global not empty")
//            print(SearchViewController.tempSaved.count)
//            return SearchViewController.tempSaved.count
//        }
        
        return 0
    }
    
    func tableView(_ savedQuotesTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedQuotesTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! QuoteTableViewCell
        

        if filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
            cell.titleLabel.text = "Quote by " + SearchViewController.tempSaved[indexPath.row].author
            let tagsText = SearchViewController.tempSaved[indexPath.row].tags.joined(separator: ", ")
            cell.detailLabel.text = "Category: " + SearchViewController.tempSaved[indexPath.row].category + " | Tags: " + tagsText
            return cell
         } else{
            cell.titleLabel.text = "Quote by " + self.filterArray[indexPath.row].author
            let tagsText = filterArray[indexPath.row].tags.joined(separator: ", ")
            cell.detailLabel.text = "Category: " + filterArray[indexPath.row].category + " | Tags: " + tagsText
            return cell
        }
        
        
    }
    
    func tableView(_ savedQuotesTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quoteViewController = QuoteViewController()
        
        if filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
            
            
            let tempQuoteObject = SearchViewController.tempSaved[indexPath.row]
            let category = tempQuoteObject.category
            quoteViewController.determineCategory(categoryParameter: category, quoteViewController: quoteViewController)
            self.navigationController?.pushViewController(quoteViewController, animated: true)
            
        } else{
            
            let tempQuoteObject = self.filterArray[indexPath.row]
            let category = tempQuoteObject.category
            quoteViewController.determineCategory(categoryParameter: category, quoteViewController: quoteViewController)
            self.navigationController?.pushViewController(quoteViewController, animated: true)
        }
        
        
        
        //        let quoteTableViewController = QuoteTableViewController()
        //        self.navigationController?.pushViewController(quoteTableViewController, animated: true)
        
    }
    
    var last: Bool = false
    func tableView(_ savedQuotesTableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
            
                SearchViewController.tempSaved.remove(at: indexPath.row)
                SearchViewController.topLevel.remove(at: indexPath.row)
            
                let jsonData = try! JSONSerialization.data(withJSONObject: SearchViewController.topLevel, options: .prettyPrinted)
                let fileManager = FileManager.default
                let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let jsonUrl = url.appendingPathComponent("save_data.json")
                try! jsonData.write(to: jsonUrl, options: .atomic)
                savedQuotesTableView.deleteRows(at: [indexPath], with: .fade)
                
            } else if !filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty {
                
                
                let objToDelete = filterArray[indexPath.row]
                
                print("Index Path to be deleted\n" )
                print(indexPath.row)
                print("Filter Array Previous size:\n")
                print(filterArray.count)
                
                print(SearchViewController.topLevel)
                print(SearchViewController.tempSaved)
                
                //get index of obj in database
                let indexOfObj = findIndex(quoteObj: objToDelete, array: SearchViewController.tempSaved/*could use toplevel[] array too*/)
                
                
                
                filterArray.remove(at: indexPath.row)
                print("Filter Array size\n" )
                print(filterArray.count)
                
                SearchViewController.tempSaved.remove(at: indexOfObj)
                SearchViewController.topLevel.remove(at: indexOfObj)
                
                
                
                let jsonData = try! JSONSerialization.data(withJSONObject: SearchViewController.topLevel, options: .prettyPrinted)
                print(jsonData)
                
                let fileManager = FileManager.default
                let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let jsonUrl = url.appendingPathComponent("save_data.json")
                try! jsonData.write(to: jsonUrl, options: .atomic)
                //self.savedQuotesTableView.reloadData()
                //savedQuotesTableView.beginUpdates()
                savedQuotesTableView.deleteRows(at: [indexPath], with: .fade)
                
                //savedQuotesTableView.endUpdates()
                //self.savedQuotesTableView.reloadData()
            }
        }
    }
    
    func findIndex(quoteObj: Quote, array: [Quote]) -> Int {
        var num: Int = 0
        for obj in array {
            if(quoteObj.quote == obj.quote){
                return num
            }
            num = num + 1
        }
        return num
    }
}





//extension SearchViewController: SaveQuoteDelegate {
//    func storeQuoteObject(quoteObject: Quote){
//
//        SearchViewController.savedQuotesArray.append(quoteObject)
//        savedQuotesTableView.reloadData()
//
//    }
//}

















// //
// //  SearchViewController.swift
// //  quote_project
// //
// //  Created by Omar Bekdash on 1/10/19.
// //  Copyright © 2018 CS 1998. All rights reserved.
// //

// import UIKit

// //protocol SaveQuoteDelegate: class {
// //    func storeQuoteObject(quoteObject: Quote)
// //}

// class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

//     var savedQuotesTableView = UITableView()
//     let reuseIdentifier = "reuseIdentifier"
//     var searchController: UISearchController!
// //    static var pathOfQuoteData = Bundle.main.url(forResource: "quote_objects", withExtension: "json")
    
//     static var pathOfQuoteData = URL(string: "/Users/theB/Library/Developer/CoreSimulator/Devices/E153BCDD-B62B-4964-B006-9D17A1014E33/data/Containers/Data/Application/E8C3EFCD-4B8C-4E85-B0C2-096C2DA06EC2/Documents/save_data.json")
//     // MARK: Search var
//     //let : SearchType = .title // TODO: You change this to search by titles or ingredients
    
//     // MARK: Model var
    
//      //for delineating a saved quote object
//     var filterArray = [Quote]()  // for filtering out an array
//     // MARK: View Lifecycle
//     static var topLevel: [AnyObject] = []
//     static var tempSaved: [Quote] = []
//     static var jsonArray: [Quote] = []
    
    
//     //@IBAction func saveArray(_ sender: )
    
//     override func viewDidLoad() {
//         super.viewDidLoad()
//         // Set navigation bar title
//         title = "Saved Quotes"
        
//         // Layout views
//         self.accessSavedQuoteData()
//         view.addSubview(savedQuotesTableView)
//         // Pin the tableview’s anchors to its superview
//         savedQuotesTableView.translatesAutoresizingMaskIntoConstraints = false
//         savedQuotesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//         savedQuotesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//         savedQuotesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//         savedQuotesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
//         // Set up tableview logic
//         savedQuotesTableView.delegate = self
//         savedQuotesTableView.dataSource = self
//         savedQuotesTableView.tableFooterView = UIView()
//         savedQuotesTableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
//         // Make tableview cells' height dynamically resize
//         savedQuotesTableView.estimatedRowHeight = 100
//         savedQuotesTableView.rowHeight = UITableView.automaticDimension
        
//         // Set up search controller logic
        
//         // Initializing with searchResultsController set to nil means that
//         // searchController will use this view controller to display the search results
//         searchController = UISearchController(searchResultsController: nil)
//         searchController.searchResultsUpdater = self
        
//         // If we are using this same view controller to present the results
//         // dimming it out wouldn't make sense. Should probably only set
//         // this to yes if using another controller to display the search results.
//         searchController.dimsBackgroundDuringPresentation = false
        
//         searchController.searchBar.placeholder = "Search by author or tag keywords"
//         searchController.searchBar.sizeToFit()
//         savedQuotesTableView.tableHeaderView = searchController.searchBar
        
//         // Sets this view controller as presenting view controller for the search interface
//         definesPresentationContext = true
        
//         //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Library", style: .plain, target: self, action: #selector(buttonTapped))
//     }
    
 
//     //THIS IS INEFFICIENT YEAH? APPDELEGATE WOULD BE BETTER
//     func accessSavedQuoteData(){
    
//         //if(SearchViewController.pathOfQuoteData == nil){ return}

//         SearchViewController.tempSaved.removeAll()
//         SearchViewController.topLevel.removeAll()
        

//         let fileManager = FileManager.default
//         let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//         let jsonUrl = url.appendingPathComponent("save_data.json")
//         //SearchViewController.pathOfQuoteData = jsonUrl
//         let jsonReadData = try! NSData(contentsOf: jsonUrl)
//         //var objects: [Quote] = []
//         //Maybe nothing is yet added to the json, so the whole thing is blank wich is why it is blanking (see top)
//         if let jsonReadData = jsonReadData{
//             let parsedQuotes = try! JSONSerialization.jsonObject(with: jsonReadData as Data, options: .mutableContainers)
//             let temp = parsedQuotes as! [[String:AnyObject]]
            
//             //print(temp)

//             for quote in temp{
                
//                 guard let quoteQuote = quote["quote"] as? String else {continue}
//                 guard let quoteAuthor = quote["author"] as? String else {continue}
//                 guard let quoteDate = quote["date"] as? String else {continue}
//                 guard let quoteTags = quote["tags"] as? [String] else {continue}
//                 guard let quoteCategory = quote["category"] as? String else {continue}
                
//                 let newQuote = Quote.init(quote: quoteQuote, author: quoteAuthor, length: "", tags: quoteTags, category: quoteCategory, title: "", date: quoteDate, permalink: "", id: "", background: "")
//                 SearchViewController.tempSaved.append(newQuote)
//                 //SearchViewController.topLevel.append(newQuote as AnyObject)
//             }
            
//             for quoteObject in SearchViewController.tempSaved {
//                 var quoteDict: [String : AnyObject] = [:]
//                 quoteDict["quote"] = quoteObject.quote as AnyObject
//                 quoteDict["author"] = quoteObject.author as AnyObject
//                 quoteDict["category"] = quoteObject.category as AnyObject
//                 quoteDict["tags"] = quoteObject.tags as AnyObject
//                 quoteDict["date"] = quoteObject.date as AnyObject
//                 //APPEND TO TOPLEVEL, WHICH IS THE DATA-STORING ARRAY
//                 SearchViewController.topLevel.append(quoteDict as AnyObject)
//             }
            
//         }
        
//     }
    
// //    func saveContext () {
// //        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
// //        if context.hasChanges {
// //            do{
// //                try context.save()
// //            } catch {
// //                let nserror = error as NSError
// //                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
// //            }
// //        }
// //    }
    
    
    
//     func updateSearchResults(for searchController: UISearchController) {
//         //There are Three cases
        
//         //search bar is unfilled:
//         //searchable array is set to the static array of all saved quotes
//         if searchBarIsUnfilled(){
//             filterArray = SearchViewController.tempSaved //previously savedQuotesArray
//             savedQuotesTableView.reloadData()
//         }
//         //search bar is **NOT** unfilled, so user is typing:
//         //searchable array gets filtered
//         else if !searchBarIsUnfilled() {
//             filterSearchInput(searchController.searchBar.text!)
//             savedQuotesTableView.reloadData()
//         }
//         //If the static array of all saved quotes is empty
//         //then the searchable array is obviously empty too
//         else if SearchViewController.tempSaved.isEmpty {
//             self.filterArray = []
//             savedQuotesTableView.reloadData()
//         }
//     }
    
//     // MARK: UISearchResultsUpdating Protocol
//     func searchBarIsUnfilled()-> Bool{
//         return searchController.searchBar.text?.isEmpty ?? true //if nil, then defaults to true
//     }
    
//     func filterSearchInput(_ searchText: String, scope: String = "All"){
//         //closure function for filtering array. If element at given index of array satisfies requirements,
//         //then it is filtered through.
//         //if author/category string or the tags array contains the searchText, it filters through
//         filterArray = SearchViewController.tempSaved.filter({ (quote : Quote) -> Bool in
//             return quote.author.lowercased().contains(searchText.lowercased()) ||
//                 quote.category.lowercased().contains(searchText.lowercased()) ||
//                 quote.tags.contains(searchText.lowercased())
//         })
//     }
    
    
//     //--------------------------------------------------------------------
//     //--------------------------------------------------------------------
//     //--------------------------------------------------------------------
//     // MARK: UITableView Data Source

    
    
// //    override func viewWillAppear(_ animated: Bool) {
// //        getData()
// //        savedQuotesTableView!.reloadData()
// //    }
    
//     func tableView(_ savedQuotesTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//         //filter array and global array both empty
//         if filterArray.isEmpty && SearchViewController.tempSaved.isEmpty{
//             return /*SearchViewController.savedQuotesArray.count*/ SearchViewController.tempSaved.count
//         }
//         //filter array empty but global array containing objects
//         else if filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
//             return SearchViewController.tempSaved.count
//         }
        
//         //If filter array containing objects (implies global array not empty)
//         else {
//             return filterArray.count
//         }

//     }
    
//     func tableView(_ savedQuotesTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = savedQuotesTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! QuoteTableViewCell
        

//         if filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
//             cell.titleLabel.text = "Quote by " + SearchViewController.tempSaved[indexPath.row].author
//             let tagsText = SearchViewController.tempSaved[indexPath.row].tags.joined(separator: ", ")
//             cell.detailLabel.text = "Category: " + SearchViewController.tempSaved[indexPath.row].category + " | Tags: " + tagsText
//             return cell
//          } else{
//             cell.titleLabel.text = "Quote by " + self.filterArray[indexPath.row].author
//             let tagsText = filterArray[indexPath.row].tags.joined(separator: ", ")
//             cell.detailLabel.text = "Category: " + filterArray[indexPath.row].category + " | Tags: " + tagsText
//             return cell
//         }
        
        
//     }
    
//     func tableView(_ savedQuotesTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let quoteViewController = QuoteViewController()
        
//         if filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
            
            
//             let tempQuoteObject = SearchViewController.tempSaved[indexPath.row]
//             let category = tempQuoteObject.category
//             quoteViewController.determineCategory(categoryParameter: category, quoteViewController: quoteViewController)
//             self.navigationController?.pushViewController(quoteViewController, animated: true)
            
//         } else{
            
//             let tempQuoteObject = self.filterArray[indexPath.row]
//             let category = tempQuoteObject.category
//             quoteViewController.determineCategory(categoryParameter: category, quoteViewController: quoteViewController)
//             self.navigationController?.pushViewController(quoteViewController, animated: true)
//         }
        
        
        
//         //        let quoteTableViewController = QuoteTableViewController()
//         //        self.navigationController?.pushViewController(quoteTableViewController, animated: true)
        
//     }
    
    
//     func tableView(_ savedQuotesTableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
//         if editingStyle == .delete {
//             if filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty{
            
//                 SearchViewController.tempSaved.remove(at: indexPath.row)
//                 SearchViewController.topLevel.remove(at: indexPath.row)
            
//                 let jsonData = try! JSONSerialization.data(withJSONObject: SearchViewController.topLevel, options: .prettyPrinted)
//                 let fileManager = FileManager.default
//                 let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                 let jsonUrl = url.appendingPathComponent("save_data.json")
//                 try! jsonData.write(to: jsonUrl, options: .atomic)
//                 savedQuotesTableView.deleteRows(at: [indexPath], with: .fade)
                
//             } else if !filterArray.isEmpty && !SearchViewController.tempSaved.isEmpty {
//                 let objToDelete = filterArray[indexPath.row]
// //                print("Index Path to be deleted\n" )
// //                print(indexPath.row)
// //                print("Filter Array Previous size:\n")
// //                print(filterArray.count)
                
//                 let indexOfObj = findIndex(quoteObj: objToDelete, array: SearchViewController.tempSaved/*could use toplevel[] array too*/)
                
                
                
//                 filterArray.remove(at: indexPath.row)
// //                print("Filter Array size\n" )
// //                print(filterArray.count)
                
//                 SearchViewController.tempSaved.remove(at: indexOfObj)
//                 SearchViewController.topLevel.remove(at: indexOfObj)
                
//                 let jsonData = try! JSONSerialization.data(withJSONObject: SearchViewController.topLevel, options: .prettyPrinted)
//                 let fileManager = FileManager.default
//                 let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                 let jsonUrl = url.appendingPathComponent("save_data.json")
//                 try! jsonData.write(to: jsonUrl, options: .atomic)
//                 savedQuotesTableView.deleteRows(at: [indexPath], with: .fade)
//             }
//         }
//     }
    
//     func findIndex(quoteObj: Quote, array: [Quote]) -> Int {
//         var num: Int = 0
//         for obj in array {
//             if(quoteObj.quote == obj.quote){
//                 return num
//             }
//             num = num + 1
//         }
//         return num
//     }
// }





// //extension SearchViewController: SaveQuoteDelegate {
// //    func storeQuoteObject(quoteObject: Quote){
// //
// //        SearchViewController.savedQuotesArray.append(quoteObject)
// //        savedQuotesTableView.reloadData()
// //
// //    }
// //}


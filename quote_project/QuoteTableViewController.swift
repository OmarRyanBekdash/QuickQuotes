//
//  QuoteTableViewController.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/15/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//

//
//  ViewController.swift
//  swift4_1_json_decode
//
//  Created by Brian Voong on 4/2/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class QuoteTableViewController: UITableViewController {
    
    let reuseIdentifier = "categoryCellReuse"
    
    struct Quote: Decodable {
        let quote: String
        let author: String?
        let length: String
        let tags: [String]
        let category: String
        let title: String
        let date: String
    }

    struct WebsiteObjectStruct: Decodable {
        let success: SuccessStruct?
        let contents: ContentsStruct?
    }

    struct SuccessStruct: Decodable{
        let total: Int?
    }

    struct ContentsStruct: Decodable{
        let quotes: [Quote]?
        let copyright:  String?
    }


    var quoteArray: [Quote] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
        
        
        
        
    }

  

    fileprivate func displayAlert(_ text: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
            let alterAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(alterAction)
            self?.present(alert, animated: true)
        }
    }

    fileprivate func fetchJSON() {
        let urlString = "http://quotes.rest/qod.json?category=inspire"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if error != nil {
                self?.displayAlert("Error fetching data: \(String(describing: error?.localizedDescription))")
            }

            let decoder = JSONDecoder()
            do {
                guard let data = data else { throw NSError(domain: "this.app", code: -1, userInfo: nil) }

                let websiteObject = try decoder.decode(WebsiteObjectStruct.self, from: data)
                if let quotesArray = websiteObject.contents!.quotes {
                    DispatchQueue.main.async {
                        self?.quoteArray = quotesArray
                        self?.tableView.reloadData()
                    }
                }
            } catch let error {
                self?.displayAlert("Error decoding json data: \(String(describing: error.localizedDescription))")
            }
            }.resume()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        let authorText = quoteArray[0].author ?? "Null author"
        let quoteText = quoteArray[0].quote ?? "Null quote"
        cell.textLabel?.text = authorText
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = quoteText
        //For quoteArray we are looking at zero index because in my JSON there
        // is ONLY EVER ONE element, located at index 0, in quoteArray
        return cell
    }





//change

//class QuoteTableViewController: UITableViewController {
//
//    var quoteArray = [Quote]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Quote List"
//        fetchJSON()
//
//    }
//
//
//    struct Quote: Decodable {
//        let quote: String
//        let author: String?
//        let length: String
//        let tags: [String]
//        let category: String
//        let title: String
//        let date: String
//
//
//
//    }
//
//    struct WebsiteObjectStruct: Decodable {
//        let success: SuccessStruct?
//        let contents: ContentsStruct?
//    }
//
//    struct SuccessStruct: Decodable{
//        let total: Int?
//    }
//
//    struct ContentsStruct: Decodable{
//        let quotes: [Quote]?
//        let copyright:  String?
//    }
//
//
//    struct Course: Decodable {
//        let id: Int
//        let name: String
//        let link: String
//
//        //        let number_of_lessons: Int
//        let numberOfLessons: Int
//        let imageUrl: String
//
//        // swift 4.0
//        private enum CodingKeys: String, CodingKey {
//            case imageUrl = "image_url"
//            case numberOfLessons = "number_of_lessons"
//            case id, name, link
//        }
//    }
////
////
////
//    fileprivate func oldFetchJSON() {
//        let urlString = "http://quotes.rest/qod.json?category=management"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, err) in
//            DispatchQueue.main.async {
//                if let err = err {
//                    print("Failed to get data from url:", err)
//                    return
//                }
//
//                guard let data = data else { return }
//
//                do {
//                    // link in description for video on JSONDecoder
//                    let decoder = JSONDecoder()
//                    // Swift 4.1
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    self.websiteObject = try decoder.decode(WebsiteObjectStruct.self, from: data)
//                    self?.tableView.reloadData()
//                } catch let jsonErr {
//                    print("Failed to decode:", jsonErr)
//                }
//            }
//            }.resume()
////
////
//    }
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return quoteArray.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
//        let authorText = quoteArray[0].author
//        cell.textLabel?.text = authorText
//        //cell.detailTextLabel?.text = String(quote.length)
//        return cell
//    }

//
//
//
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! QuoteTableViewCell
////        let quoteObjectPassedOntoCell = quoteObject
////        cell.configure(for: quoteObject)
////        cell.setNeedsUpdateConstraints()
////        cell.selectionStyle = .none
////        return cell
////
////
////
////    }

}

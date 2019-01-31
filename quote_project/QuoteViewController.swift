////
////  QuoteViewController.swift
////  quote_project
////
////  Created by Omar Beckdash on 1/12/19.
////  Copyright © 2019 Omar Bekdash. All rights reserved.
////
//
//import UIKit
//
//

//AIzaSyDUbNvrriOwQP8HkVRNNLK4K06tWAHGX1I API key
//006599334025039600654:dlr0gznrbas quoteSearchEngine search engine ID

//var picStruct: WikiStruct!
import UIKit
import Foundation


class QuoteViewController: UIViewController, UITextViewDelegate {
    
    var webStruct: WebsiteObjectStruct!
    var quoteTextView: UITextView! // will include author
    var tagsLabel: UILabel!
    var changePicLabel: UITextView!
    var copyrightAndDateLabel: UILabel!
    var categoryLabel: UILabel!
    static var authorImage: UIImageView!
    @IBOutlet var wikiText: UITextView!
    

    var tagsString: String!
    var lengthString: String!
    var authorString: String!
    var categoryString: String!
    var quoteString: String!
    var dateString: String!
    var wikiLinkString: String!
    var quoteObject: Quote!
    static var imageUrl: String?
    
    //weak var delegate: SaveQuoteDelegate?
    
    var savedQuotesArray: [Quote] = []
    




    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        //self.view.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        
        quoteTextView = UITextView()
        quoteTextView.translatesAutoresizingMaskIntoConstraints = false
        quoteTextView.textAlignment = .center
        quoteTextView.textColor = .black
        quoteTextView.font = UIFont.systemFont(ofSize: 17, weight: .bold).italic()
        quoteTextView.isEditable = false
        //quoteTextView.font = UIFont.preferredFont(forTextStyle: .footnote).italic()
        view.addSubview(quoteTextView)
        
        copyrightAndDateLabel = UILabel()
        copyrightAndDateLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightAndDateLabel.textAlignment = .left
        copyrightAndDateLabel.textColor = UIColor(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1)
        copyrightAndDateLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        copyrightAndDateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        view.addSubview(copyrightAndDateLabel)
        
        changePicLabel = UITextView()
        changePicLabel.translatesAutoresizingMaskIntoConstraints = false
        changePicLabel.textAlignment = .left
        changePicLabel.textColor = UIColor(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1)
        changePicLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        changePicLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        changePicLabel.text = "Click this image to get a new one"
        view.addSubview(changePicLabel)
        
        
        tagsLabel = UILabel()
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsLabel.textAlignment = .left
        tagsLabel.textColor = .black
        tagsLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.addSubview(tagsLabel)
        
        
        categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textAlignment = .left
        categoryLabel.textColor = .black
        categoryLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.addSubview(categoryLabel)
        
        wikiText = UITextView()
        wikiText.translatesAutoresizingMaskIntoConstraints = false
        wikiText.textAlignment = .center
        wikiText.textColor = .black
        wikiText.isSelectable = true
        wikiText.isEditable = false
        view.addSubview(wikiText)
        
        QuoteViewController.authorImage = UIImageView()
        QuoteViewController.authorImage.translatesAutoresizingMaskIntoConstraints = false
        QuoteViewController.authorImage.contentMode = .scaleAspectFit
        QuoteViewController.authorImage.isUserInteractionEnabled = true
        QuoteViewController.authorImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        view.addSubview(QuoteViewController.authorImage)
        
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Quote", style: .plain, target: self, action: #selector(saveQuote))
        
        setupConstraints()
    }
    
    let defaults = UserDefaults.standard
    override func viewWillAppear(_ animated: Bool) {
        if let textUnitString = defaults.string(forKey: UserDefaultsKey.textSize.rawValue), let textUnit =
            TextUnit(rawValue: textUnitString){
            
            if(textUnitString == "big"){
                quoteTextView.font = UIFont.systemFont(ofSize: 21, weight: .bold).italic()
                
                
            } else {
                quoteTextView.font = UIFont.systemFont(ofSize: 17, weight: .bold).italic()
                
            }
            
        }
    }
    
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        let rand = Int.random(in: 0 ... 1000)
        let stringifiedNumber = "\(rand)"
        downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
    }
//    @IBOutlet var quote: String!
//    @IBOutlet var author: String!
//    @IBOutlet var category: String!
//    @IBOutlet var length: String!
//    @IBOutlet var date: String!
//    @IBOutlet var tags: [String]!
//    @IBOutlet var permalink: String!
//    @IBOutlet var id: String!
//    @IBOutlet var background: String!
    
    
    
    
    @objc func saveQuote(){
        if arrayContainsDuplicateQuote(quoteObject: webStruct.contents.quotes[0]) == "No Duplicate Found" {
            
            savedQuotesArray.append(webStruct.contents.quotes[0])
            
            for quoteObject in savedQuotesArray {
                var quoteDict: [String : AnyObject] = [:]
                quoteDict["quote"] = quoteObject.quote as AnyObject
                quoteDict["author"] = quoteObject.author as AnyObject
                quoteDict["category"] = quoteObject.category as AnyObject
                quoteDict["tags"] = quoteObject.tags as AnyObject
                quoteDict["date"] = quoteObject.date as AnyObject
                //APPEND TO TOPLEVEL, WHICH IS THE DATA-STORING ARRAY
                SearchViewController.topLevel.append(quoteDict as AnyObject)
            }
            //
            let jsonData = try! JSONSerialization.data(withJSONObject: SearchViewController.topLevel, options: .prettyPrinted)
            //--------
            let fileManager = FileManager.default
            let url = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let jsonUrl = url.appendingPathComponent("save_data.json")
            //SearchViewController.pathOfQuoteData = jsonUrl
            try! jsonData.write(to: jsonUrl, options: .atomic)
            
            //-----
            
            
            //try! jsonData.write(to: SearchViewController.pathOfQuoteData!, options: .atomic)
     
                let searchViewController = SearchViewController()
            self.navigationController?.pushViewController(searchViewController, animated: true)
            
            } else {
            
            let alert = UIAlertController(title: "Quote is already in your library", message: "It's alright. . . just save another quote to your collection 😝", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    func arrayContainsDuplicateQuote(quoteObject: Quote) -> String{
        for quoteAtIndex in SearchViewController.tempSaved {
            if quoteAtIndex.quote == quoteObject.quote {
                return "Found Duplicate"
            }
        }
        return "No Duplicate Found"
    }

    
    
    func setupConstraints() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        //let screenHeight = screenSize.height
        
        NSLayoutConstraint.activate([
            
            changePicLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            changePicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth/3.9 ),
            changePicLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            changePicLabel.bottomAnchor.constraint(equalTo: QuoteViewController.authorImage.topAnchor, constant: -10),
            //            QuoteViewController.authorImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth/4),
            //            QuoteViewController.authorImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * screenWidth/4),
            QuoteViewController.authorImage.heightAnchor.constraint(equalToConstant: 230),
            QuoteViewController.authorImage.widthAnchor.constraint(equalToConstant: 230),
            
            QuoteViewController.authorImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            QuoteViewController.authorImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 95),
//            QuoteViewController.authorImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth/4),
//            QuoteViewController.authorImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * screenWidth/4),
            QuoteViewController.authorImage.heightAnchor.constraint(equalToConstant: 230),
            QuoteViewController.authorImage.widthAnchor.constraint(equalToConstant: 230),
//
            quoteTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            quoteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth/8),
            quoteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * screenWidth/8),
            quoteTextView.heightAnchor.constraint(equalToConstant: 180),
            
            wikiText.topAnchor.constraint(equalTo: quoteTextView.bottomAnchor, constant: 15),
            wikiText.leadingAnchor.constraint(equalTo: quoteTextView.leadingAnchor, constant: screenWidth/10),
            wikiText.trailingAnchor.constraint(equalTo: quoteTextView.trailingAnchor, constant: -1 * screenWidth/10),
            wikiText.heightAnchor.constraint(equalToConstant: 50),

            categoryLabel.topAnchor.constraint(equalTo: wikiText.bottomAnchor, constant: 30),
            categoryLabel.leadingAnchor.constraint(equalTo: quoteTextView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: quoteTextView.trailingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tagsLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 30),
            tagsLabel.leadingAnchor.constraint(equalTo: quoteTextView.leadingAnchor),
            tagsLabel.trailingAnchor.constraint(equalTo: quoteTextView.trailingAnchor),
            tagsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            copyrightAndDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            copyrightAndDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            copyrightAndDateLabel.heightAnchor.constraint(equalToConstant: 16)
            
            ])
    }

    //Determine which category this ViewController will show
    func determineCategory(categoryParameter: String, quoteViewController: QuoteViewController){
        let rand = Int.random(in: 0 ... 1000)
        let stringifiedNumber = "\(rand)"
        
        switch categoryParameter {
            case "management":
                title = "Management Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=management", quoteViewController: quoteViewController)

                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            
            case "inspire":
                title = "Inspiring Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=inspire",quoteViewController: quoteViewController)
                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            case "sports":
                title = "Sports Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=sports",quoteViewController: quoteViewController)
                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            case "life":
                title = "Life Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=life",quoteViewController: quoteViewController)
                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            case "funny":
                title = "Funny Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=funny",quoteViewController: quoteViewController)
                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            case "love":
                title = "Love Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=love",quoteViewController: quoteViewController)
                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            case "art":
                title = "Art Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=art",quoteViewController: quoteViewController)
                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            case "students":
                title = "Students Quote"
                MainNetworkManager.fetchJSON(fetchUrl: "http://quotes.rest/qod.json?category=students",quoteViewController: quoteViewController)
                downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!)
            default:
                print("Unexplained Error")
        }
    }
    

    
    //Get JSON Information from fetchJSON() and
    //fill in the UILabels with the information
    func setupLabels(obj: WebsiteObjectStruct){
        let quotePackage: Quote = obj.contents.quotes[0]
        let str = quotePackage.author
        let arr = str.split(separator: " ")
        //self.displayImage(authorNameArray: arr)
        self.makeHyperlink(authorNameArray: arr) // set wiki hyperlink
        
        quoteTextView.text = quotePackage.quote + "\n         -" + quotePackage.author // set quote
        copyrightAndDateLabel.text = "Date received: " + quotePackage.date + ".  " + "Copyright: 2017-19 theysaidso.com"
        //set the copyright stuff
        tagsLabel.text = "Tags: " + quotePackage.tags.joined(separator: ", ")
        //set tags
        categoryLabel.text = "Category: " + quotePackage.category
        //set category
        
    }
    

    

    
    func downloadImage(from url: URL) {
//        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
            DispatchQueue.main.async() {
                QuoteViewController.authorImage.image = UIImage(data: data)
                QuoteViewController.authorImage.layer.borderWidth = 3
                QuoteViewController.authorImage.layer.masksToBounds = false
                QuoteViewController.authorImage.layer.borderColor = UIColor.black.cgColor
                QuoteViewController.authorImage.layer.cornerRadius = QuoteViewController.authorImage.frame.height/2
                QuoteViewController.authorImage.clipsToBounds = true
                self.view.addSubview(QuoteViewController.authorImage)
                
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
//    func displayImage(url: String){
//
//        let arr = webStruct.contents.quotes[0].author.split(separator: " ")
//        if searchForInvalidAuthor(authorNameArray: arr) == "Found valid text" {
//            //let authorNameUnderscored = arr.joined(separator: "_")
//            authorImage.downloaded(from: url/*"https://en.wikipedia.org/w/api.php?action=query&prop=pageimages&titles="
//                                        + authorNameUnderscored + "&pithumbsize=180"*/)
//        }
//    }


    //make hyperlink to visit wiki page on the author
    func makeHyperlink(authorNameArray: [Substring]) {
        let authorNameUnderscored = authorNameArray.joined(separator: "_") // "1-2-3
        let authorNameSpaced = authorNameArray.joined(separator: " ")
        
        if searchForInvalidAuthor(authorNameArray: authorNameArray) == "Found valid text" {
            let attributedString = NSMutableAttributedString(string: "Click here to learn more about " + authorNameSpaced)
            attributedString.addAttribute(.link, value: "https://www.wikipedia.org/wiki/" + authorNameUnderscored, range: NSRange(location: 0, length: 10))
            wikiText.attributedText = attributedString
            wikiText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            wikiText.textAlignment = .center
        }
    }
    
   
    //Search if the author is invalid and cant be searched on wikipedia
    func searchForInvalidAuthor(authorNameArray: [Substring]) -> String{
        for text in authorNameArray {
            if (text == "proverb" || text == "Proverb" ||
                text == "unknown" || text == "Unknown") {
                return "Found unacceptable text"
            }
        }
        return "Found valid text"
    }

    //PURPOSE IS FOR WIKITEXT HYPERLINK
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
    
}

extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}






















// 01/17/19  OLDFETCHJSON Function

//    fileprivate func fetchJSON(fetchUrl: String) {
//        let urlString = fetchUrl
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            if error != nil {
//                self?.displayAlert("Error fetching data: \(String(describing: error?.localizedDescription))")
//            }
//
//            let decoder = JSONDecoder()
//            do {
//                guard let data = data else { throw NSError(domain: "this.app", code: -1, userInfo: nil) }
//
//                let websiteObject = try decoder.decode(WebsiteObjectStruct.self, from: data)
//                //GLOBAL WAY self.webStruct = try decoder.decode(WebsiteObjectStruct.self, from: data)
//                if let quotesArray = websiteObject.contents!.quotes {
//                    DispatchQueue.main.async {
////                        self?.quoteArray = quotesArray
////                        self?.reloadInputViews()
//                        self?.setupLabels(array: quotesArray)
//                    }
//                }
//            } catch let error {
//                self?.displayAlert("Error decoding json data: \(String(describing: error.localizedDescription))")
//            }
//            }.resume()
//    }




//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//            }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}




//    //Request JSON Format from the wep API
//    fileprivate func fetchJSON(fetchUrl: String) {
//        let urlString = fetchUrl
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
//                    self.webStruct = try decoder.decode(WebsiteObjectStruct.self, from: data)
////                        self?.quoteArray = quotesArray
////                        self?.reloadInputViews()
//                    let tempStruct = try decoder.decode(WebsiteObjectStruct.self, from: data)
//
//                    //print(self.webStruct.contents?.quotes![0])
//                    SearchViewController.savedQuotesArray.append((tempStruct.contents?.quotes![0])!)
//                    print("asdfasdf\n")
//                    //print(SearchViewController.savedQuotesArray)
//                    self.quoteObject = self.webStruct.contents?.quotes![0]
//                    self.setupLabels(array: (self.webStruct.contents?.quotes)!)
//
//
//                } catch let jsonErr {
//                    print("Failed to decode:", jsonErr)
//                }
//            }
//            }.resume()
//    }
//    //Display error while requesting the JSON
//    fileprivate func displayAlert(_ text: String) {
//        DispatchQueue.main.async { [weak self] in
//            let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
//            let alterAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//            alert.addAction(alterAction)
//            self?.present(alert, animated: true)
//        }
//    }

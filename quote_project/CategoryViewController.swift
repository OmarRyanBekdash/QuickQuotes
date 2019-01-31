//
//  CategoryViewController.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/30/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//

import UIKit

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var quoteTextView: UITextView!
    var categoryCollectionView: UICollectionView!
    
    var categoryArray : [Category]!
    var refreshControl = UIRefreshControl()
    //var counter : Int = 0
    
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    
    
    
    //let headerReuseIdentifier = "headerReuseIdentifier"
    let padding: CGFloat = 8
    let topPadding: CGFloat = 32
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Choose your quote"
        view.backgroundColor = .white
        
        categoryArray = [
            Category(cellTitle: "Inspiring", id: "inspire"),
            Category(cellTitle: "Leadership",id: "management"),
            Category(cellTitle: "Sports", id: "sports"),
            Category(cellTitle: "Life", id: "life"),
            Category(cellTitle: "Amusing", id: "funny"),
            Category(cellTitle: "Love", id: "love"),
            Category(cellTitle: "Art", id: "art"),
            Category(cellTitle: "Students", id: "students")
        ]
        
        
        //refreshControl = UIRefreshControl()
        // refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        // Setup Collection View
        // UICollectionViewFlowLayout is used to help organize our cells/items into a grid-pattern
        
        let layout = UICollectionViewFlowLayout()
        // scrollDirection can be vertical or horizontal
        layout.scrollDirection = .vertical //layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding/4
        layout.minimumLineSpacing = padding*2
        
        let layout2 = UICollectionViewFlowLayout()
        // scrollDirection can be vertical or horizontal
        layout2.scrollDirection = .horizontal //layout.scrollDirection = .vertical
        layout2.minimumInteritemSpacing = padding*2
        layout2.minimumLineSpacing = padding*3
        

        /*
         
         REGISTER FILTER CELLS
         
         */
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.backgroundColor = .white
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        //        categoryCollectionView.refreshControl = refreshControl
        categoryCollectionView.register(CategoryTableViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        view.addSubview(categoryCollectionView)
        
        quoteTextView = UITextView()
        quoteTextView.translatesAutoresizingMaskIntoConstraints = false
        quoteTextView.textAlignment = .center
        quoteTextView.textColor = .black
        quoteTextView.layer.borderColor = UIColor.black.cgColor
        quoteTextView.layer.borderWidth = 1
        quoteTextView.font = UIFont.systemFont(ofSize: 18, weight: .bold).italic()
        quoteTextView.isEditable = false
        quoteTextView.text = "An apt quotation is like a lamp which flings its light over the whole sentence.\n      -Letitia Elizabeth Landon"
        //quoteTextView.font = UIFont.preferredFont(forTextStyle: .footnote).italic()
        view.addSubview(quoteTextView)
        
        //        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        //
        
        
        
        
        setupConstraints()
    }
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        if let textUnitString = defaults.string(forKey: UserDefaultsKey.textSize.rawValue), let textUnit =
            TextUnit(rawValue: textUnitString){
            
            if(textUnitString == "big"){
                quoteTextView.font = UIFont.systemFont(ofSize: 23, weight: .light)
            } else {
                quoteTextView.font = UIFont.systemFont(ofSize: 18, weight: .light)
            }
            
        }
    }
    
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            categoryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            quoteTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            quoteTextView.bottomAnchor.constraint(equalTo: categoryCollectionView.topAnchor, constant: -110),
            quoteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            quoteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
            ])
    }
    
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
    //        let restaurant = restaurantsArray[indexPath.item]
    //        cell.configure(for: restaurant)
    //        cell.setNeedsUpdateConstraints()
    //
    //        return cell
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        return restaurantsArray.count
    //    }
    //
    ////    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    ////        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
    ////        headerView.setNeedsUpdateConstraints()
    ////        return headerView
    ////    }
    //
    //    // MARK: - UICollectionViewDelegate (all of these methods are optional)
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        // Run some code upon tapping a cell
    //        // For example, if we wanted to remove the cell upon tap:
    //        restaurantsArray.remove(at: indexPath.item)
    //        collectionView.reloadData()
    //    }
    //
    //    // MARK: - UICollectionViewDelegateFlowLayout
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        // We want || padding IMAGE padding IMAGE padding IMAGE padding ||
    //        let length = (collectionView.frame.width - padding * 4) / 3.0
    //        return CGSize(width: length, height: length)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: collectionView.frame.width, height: headerHeight)
    //    }
    
    
    //------------------------------------------------------------------------------------------------------------------------
    //------------------------------------------------------------------------------------------------------------------------
    
//    func convertStringToEnum(buttonText : String) -> [FoodTypes]{
//        var enumArray : [FoodTypes]!
//        if(buttonText == "Asian"){
//            enumArray.append(.Asian)
//        }
//        if(buttonText == "Mexican"){
//            enumArray.append(.Mexican)
//        }
//        if(buttonText == "Fast Food"){
//            enumArray.append(.Mexican)
//        }
//        return enumArray
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! CategoryTableViewCell
            let category = categoryArray[indexPath.row]
            cell.configure(for: category.cellTitle)
        
        
            cell.setNeedsUpdateConstraints()
            //cell.selectionStyle = .none
            return cell
            
        
//
//        else {
//            //let cellB = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewBIdentifier) as UICollectionViewCell
//            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for : indexPath) as! RestaurantCollectionViewCell
//            let restaurant = restaurantsArray[indexPath.item]
//
//            //CONFIGURES FOR EACH CELL
//            //if some fucntion that determines a good restaurant then configure
//            cellA.configure(for: restaurant)
//            cellA.setNeedsUpdateConstraints()
//
//
//            return cellA
//        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //        if collectionView == self.collectionView {
        //            return restaurantsArray.count // Replace with count of your data for collectionViewA
        //        } else {
        //            return categoryArray.count
        //        }
        

            return categoryArray.count // Replace with count of your data for collectionViewA
        
//        else {
//            return restaurantsArray.count
//        }
        
        
    }
    
    //
    //
    // MARK: - UICollectionViewDelegate (all of these methods are optional)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryTableViewCell {
            
           
            UIView.animate(withDuration: 1, delay: 0.7, options: UIView.AnimationOptions.curveEaseOut, animations: {
                cell.categoryLabel.layer.borderWidth = 3
                
            }, completion: {
                (finished: Bool) -> Void in
                
                //Once the label is completely invisible, set the text and fade it back in

                cell.categoryLabel.layer.borderWidth = 1
                // Fade in
            })
            
            let quoteViewController = QuoteViewController()
            let category = self.categoryArray[indexPath.row]
            quoteViewController.determineCategory(categoryParameter: category.id, quoteViewController: quoteViewController)
            self.navigationController?.pushViewController(quoteViewController, animated: true)
//
//            let quoteViewController = QuoteViewController()
//            let category = categoryArray[indexPath.row]
//            quoteViewController.determineCategory(categoryParameter: category.id, quoteViewController: quoteViewController)
//            self.navigationController?.pushViewController(quoteViewController, animated: true)
 
        }
        
//        else {
//            // bool clicked = true
//            //restaurantsArray.remove(at: indexPath.item)
//            //            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
//            //            cellA.backgroundColor = .red
//            collectionView.reloadData()
//        }
        
        
    }
    
    
    
    
    
    
    
    
    
    //
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        //        if collectionView == self.collectionView {
        //            let length = (collectionView.frame.width - padding * 4) / 3.0
        //            return CGSize(width: length, height: length)
        //            //return restaurantsArray.count // Replace with count of your data for collectionViewA
        //        } else {
        //            return CGSize(width: 40, height: 20)
        //        }
        

            return CGSize(width: 200, height: 150)

//        else {
//            let length = (collectionView.frame.width - padding * 4) / 3.0
//            return CGSize(width: length, height: length)
//
//        }
        
}

//    @objc func pulledToRefresh() {
//        // Place some code here that fetches new data
//        // Then call refreshControl.endRefreshing() once we get that data back
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.refreshControl.endRefreshing()
//        }
//    }
}

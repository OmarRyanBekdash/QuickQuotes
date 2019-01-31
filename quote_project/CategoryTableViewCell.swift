//
//  CategoryTableViewCell.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/12/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//


import UIKit

class CategoryTableViewCell: UICollectionViewCell {
    
    var categoryLabel : UILabel!
    //var button : UIButton!
    //var isPressed = true
    
    //var counter : Int = 0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        categoryLabel.textColor = .black
        //categoryLabel.tintColor = .blue
        categoryLabel.textAlignment = .center
        categoryLabel.layer.borderColor = UIColor.black.cgColor
        categoryLabel.layer.borderWidth = 1
        //categoryLabel.backgroundColor = UIColor(red: 0, green: 0.85, blue: 0.25, alpha: 0.55)
        let red = Double.random(in: 1 ... 6) / 10
        let green = Double.random(in: 1 ... 6) / 10
        let blue = Double.random(in: 1 ... 6) / 10
        let alpha = Double.random(in: 1 ... 6) / 10
        categoryLabel.backgroundColor = UIColor(red: CGFloat(red),
                                                green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        //        mylabel.layer.cornerRadius = yourvalue
        //        if you dont want to shadow then add
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        // set the cornerRadius of the containerView's layer
        categoryLabel.layer.cornerRadius = 6
        categoryLabel.layer.masksToBounds = true
        
       
        
        
        contentView.addSubview(categoryLabel)
        
        //        filterLabel = UILabel()
        //        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        //        //filterLabel.contentMode = .scaleAspectFit
        //        filterLabel.textColor = .black
        //        filterLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        ////        filterLabel.backgroundColor = UIColor(red: 0, green: 0.85, blue: 0.25, alpha: 0.55)
        ////        //        mylabel.layer.cornerRadius = yourvalue
        ////        //        if you dont want to shadow then add
        ////        layer.backgroundColor = UIColor.clear.cgColor
        ////        layer.shadowColor = UIColor.black.cgColor
        ////        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        ////        layer.shadowOpacity = 0.2
        ////        layer.shadowRadius = 4.0
        ////        // set the cornerRadius of the containerView's layer
        ////        filterLabel.layer.cornerRadius = 6
        ////        filterLabel.layer.masksToBounds = true
        //        contentView.addSubview(filterLabel)
//        contentView.addSubview(button)
        
    }
    
    override func updateConstraints() {
        
        //        NSLayoutConstraint.activate([
        //
        //            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        //            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        //            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        //           ])
        NSLayoutConstraint.activate([
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        super.updateConstraints()
        
    }
    
    
    func configure(for category: String){
        categoryLabel.text = capitalizingFirstLetter(ctgry: category)
        
    }
    
    func capitalizingFirstLetter(ctgry: String) -> String {
        let first = String(ctgry.prefix(1)).capitalized
        let other = String(ctgry.dropFirst())
        return first + other
    }
    
    
    
    //    func filterPressedActions(){
    //        filterLabel.backgroundColor = UIColor(red: 0.9, green: 0.23, blue: 0.4, alpha: 0.55)
    //        if(isPressed == true){
    //            print("sel")
    //            isPressed = false
    //            filterLabel.backgroundColor = UIColor(red: 0.9, green: 0.23, blue: 0.4, alpha: 0.55)
    //            contentView.addSubview(filterLabel)
    //        }else if (isPressed == false){
    //            print("desel")
    //            isPressed = true
    //            filterLabel.backgroundColor = UIColor(red: 0, green: 0.85, blue: 0.25, alpha: 0.55)
    //            contentView.addSubview(filterLabel)
    //        }
    //
    //
    //    }
    //         if(isPressed == true){
    //                    print("sel")
    //                    isPressed = false
    //                    //filterLabel.backgroundColor = UIColor(red: 0.9, green: 0.23, blue: 0.4, alpha: 0.55)
    //
    //                }else if (isPressed == false){
    //                    print("desel")
    //                    isPressed = true
    //                    //filterLabel.backgroundColor = UIColor(red: 0, green: 0.85, blue: 0.25, alpha: 0.55)
    //
    //                }
    //isPressed = !isPressed
    
    //        if filterLabel.backgroundColor == UIColor(red: 0, green: 0.85, blue: 0.25, alpha: 0.55) {
    //                filterLabel.backgroundColor = UIColor(red: 0.9, green: 0.23, blue: 0.4, alpha: 0.55)
    //                print("sel")
    //         } else if (filterLabel.backgroundColor == UIColor(red: 0.9, green: 0.23, blue: 0.4, alpha: 0.55)) {
    //                filterLabel.backgroundColor = UIColor(red: 0, green: 0.85, blue: 0.25, alpha: 0.55)
    //                print("desel")
    //        }
    
    
    
    
    
    
    //        if(isPressed == true){
    //            filterLabel.backgroundColor = UIColor(red: 0.9, green: 0.23, blue: 0.4, alpha: 0.55)
    //
    //        }else if (isPressed == false){
    //
    //            filterLabel.backgroundColor = UIColor(red: 0, green: 0.85, blue: 0.25, alpha: 0.55)
    //        }
    //        isPressed = !isPressed
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





//
//
//import UIKit
//
//class CategoryTableViewCell: UITableViewCell {
//
//    var categoryLabel : UILabel!
//
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        categoryLabel = UILabel()
//        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
//        categoryLabel.font = UIFont.systemFont(ofSize: 17)
//        categoryLabel.textColor = .black
//        categoryLabel.tintColor = .blue
//        categoryLabel.textAlignment = .center
//
//        contentView.addSubview(categoryLabel)
//        // Initialization code
//    }
//
//    func configure(for category: String){
//        categoryLabel.text = capitalizingFirstLetter(ctgry: category)
//
//    }
//
//    func capitalizingFirstLetter(ctgry: String) -> String {
//        let first = String(ctgry.prefix(1)).capitalized
//        let other = String(ctgry.dropFirst())
//        return first + other
//    }
//
////    func getCategory(category: String) -> String{
////        return (categoryLabel.text?.lowercased())!
////
////    }
//
//
//
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

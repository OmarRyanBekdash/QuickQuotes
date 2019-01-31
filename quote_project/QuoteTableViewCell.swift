//
//  QuoteTableViewCell.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/15/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//


import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide
        
        // Configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0 // make label multi-line
        
        // Configure detailLabel
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        // Constrain detailLabel’s topAnchor to titleLabel's bottom anchor
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0 // make label multi-line
        detailLabel.textColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


































//VERY OLD
//
//import UIKit
//
//class QuoteTableViewCell: UITableViewCell {
//
//    var quoteLabel: UILabel! // will include author
//    //var authorLabel: UILabel!
//    //var lengthLabel: UILabel! //Most likely will be private info
////    var tagsLabel: UILabel!
////    var dateLabel: UILabel!
////
//    let padding: CGFloat = 12
//    let fieldHeight: CGFloat = 13
//    let anImageHeight: CGFloat = 70
//    let anImageWidth: CGFloat = 70
//
////    override func setSelected(_ selected: Bool, animated: Bool) {
////        super.setSelected(selected, animated: animated)
////
////        // Configure the view for the selected state
////    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        quoteLabel = UILabel()
//        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
//        quoteLabel.font = UIFont.systemFont(ofSize: 4)
//        quoteLabel.textColor = .black
//        contentView.addSubview(quoteLabel)
//    }
//
//
//
//    override func updateConstraints() {
////        NSLayoutConstraint.activate([
////            quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
////            quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
////            quoteLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
////            quoteLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
////            ])
//
//        NSLayoutConstraint.activate([
//            quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
//            quoteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
//            quoteLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
//            ])
//
//        super.updateConstraints()
//    }
//
////    func configure(for quote: WebsiteObjectStruct){
////        quoteLabel.text = quote.contents.quotes[0].author
////
////    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

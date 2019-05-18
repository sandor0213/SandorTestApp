//
//  SearchResultTableViewCell.swift
//  SandorTestApp
//
//  Created by Balogh Sandor on 5/18/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(searchImageView)
        self.addSubview(label)
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        searchImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingAnchor).isActive = true
        searchImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        searchImageView.widthAnchor.constraint(equalTo: searchImageView.heightAnchor).isActive = true
        
        label.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: Constants.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.leadingAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: Constants.heightAnchorMultiplier).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setUp(searchedWord: String, searchImageStringURL: String) {
        self.label.text = searchedWord
        self.searchImageView.image = searchImageStringURL.getImageFromStringUrl()
    }
    
}


extension SearchResultTableViewCell {
    struct Constants {
        static let leadingAnchor: CGFloat = 20
        static let heightAnchorMultiplier: CGFloat = 0.5
    }
    
}



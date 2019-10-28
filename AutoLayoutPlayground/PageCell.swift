//
//  PageCell.swift
//  AutoLayoutPlayground
//
//  Created by Adrian Kremski on 28/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import Foundation
import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let safePage = page else { return }
                
            logoImageView.image = UIImage(named: safePage.imageName)
            
            let attributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(18))
            ]
            
            let attributedText = NSMutableAttributedString(string: safePage.title, attributes: attributes)
            
            let subtitleAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(13)),
                NSAttributedString.Key.foregroundColor : UIColor.gray        ]
                
            attributedText.append(NSAttributedString(string: "\n\n\n\(safePage.description)", attributes: subtitleAttributes))
            
            descriptionTextView.attributedText = attributedText
            
            descriptionTextView.textAlignment = .center
        }
    }
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
       

    private func setupLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.backgroundColor = .white
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
           
        topImageContainerView.addSubview(logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.6).isActive = true

        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
   }
}

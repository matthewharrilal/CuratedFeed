//
//  ArticleCardCollectionViewCell.swift
//  CuratedFeed
//
//  Created by Space Wizard on 8/3/24.
//

import Foundation
import UIKit

class ArticleCardCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        String(describing: ArticleCardCollectionViewCell.self)
    }
    
    private var colors: [UIColor] = [UIColor(hex: "998650"), UIColor(hex: "A2C5AC"), UIColor(hex: "0C7C59"), UIColor(hex: "EC7357"), UIColor(hex: "CBC5EA"),  UIColor(hex: "B26E63"), UIColor(hex: "8FBFE0 "), UIColor(hex: "ED7B84"), UIColor(hex: "7EB77F")]
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = colors.randomElement()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleCardCollectionViewCell {
    
    func setup() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

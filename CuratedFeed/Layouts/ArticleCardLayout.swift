//
//  ArticleCardLayout.swift
//  CuratedFeed
//
//  Created by Space Wizard on 8/3/24.
//

import Foundation
import UIKit

class ArticleCardLayout: UICollectionViewLayout {
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth: CGFloat {
        collectionView?.bounds.width ?? 0
    }
    
    private var contentHeight: CGFloat = 0
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        contentHeight = 0
        
        let numberOfSections = collectionView.numberOfSections
        let numberOfItems = collectionView.numberOfItems(inSection: numberOfSections - 1)
        
        let itemSize = CGSize(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 2)
        let spacing: CGFloat = itemSize.height * 0.1
        let horizontalSpacing: CGFloat = itemSize.width * 0.15
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: numberOfSections - 1)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let xOffset = CGFloat(item) * horizontalSpacing
            let yOffset = CGFloat(item) * spacing
            
            let xPos = (collectionView.bounds.width - itemSize.width) / 2 + xOffset
            let yPos = (UIScreen.main.bounds.height / 8) + yOffset
            
            let frame = CGRect(x: xPos, y: yPos, width: itemSize.width, height: itemSize.height)
            
            attributes.frame = frame
            
            let angle: CGFloat = CGFloat(item) * CGFloat(0.08) // Adjust this angle for more or less tilt
            attributes.transform = CGAffineTransform(rotationAngle: angle)
            
            attributes.zIndex = (numberOfItems - 1) - item
            cache.append(attributes)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache.first { $0.indexPath == indexPath }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache.filter { $0.frame.intersects(rect) }
    }
}

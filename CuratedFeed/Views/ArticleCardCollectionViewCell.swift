//
//  ArticleCardCollectionViewCell.swift
//  CuratedFeed
//
//  Created by Space Wizard on 8/3/24.
//

import Foundation
import UIKit

class ArticleCardCollectionViewCell: UICollectionViewCell {
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
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
        
        setupPanGestureRecognizer()
    }
    
    func setupPanGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let collectionView = superview as? UICollectionView else { return }
        
        let translation = gesture.translation(in: self)
        center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
        gesture.setTranslation(.zero, in: self)
        
        if gesture.state == .began || gesture.state == .changed {
            if let indexPath = collectionView.indexPath(for: self) {
                (collectionView.collectionViewLayout as? ArticleCardLayout)?.focusedIndexPath = indexPath
            }
        }
        
        if gesture.state == .ended {
            if abs(center.x - (collectionView.bounds.width / 2)) < 100 {
                UIView.animate(withDuration: 0.25) {
                    self.center = self.superview?.center ?? self.center
                }
            } else {
                if let indexPath = collectionView.indexPath(for: self) {
                    (collectionView.dataSource as? HomeViewController)?.dummyData.remove(at: indexPath.item)
                    collectionView.performBatchUpdates({
                        collectionView.deleteItems(at: [indexPath])
                    }, completion: nil)
                }
            }
            
            // Reset focusedIndexPath after the gesture ends
            (collectionView.collectionViewLayout as? ArticleCardLayout)?.focusedIndexPath = nil
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

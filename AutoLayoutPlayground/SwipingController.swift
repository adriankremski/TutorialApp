//
//  SwipingController.swift
//  AutoLayoutPlayground
//
//  Created by Adrian Kremski on 28/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let pages = [
        Page(imageName: "bear_first", title: "Join us today in our fun and games!",
             description: "Are you ready for load and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", title: "Subscribe and get coupon on our daily events",
             description: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "leaf_third", title: "Vip members special services",
             description: "Some kind of description")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(14))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrev() {
        if (pageControl.currentPage > 0) {
            let prevIndex = pageControl.currentPage - 1
            let indexPath = IndexPath(item: prevIndex, section: 0)
            pageControl.currentPage = prevIndex
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)

        return pc
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.mainPink, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(14))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)

        return button
    }()
    
    @objc private func handleNext() {
        if (pageControl.currentPage < pages.count - 1) {
            let nextIndex = pageControl.currentPage + 1
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        setupBottomControls()
    }
    
    private func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [
           previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
       
        view.addSubview(bottomControlsStackView)

        bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
   }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        cell.page = pages[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }, completion: nil)
    }
}

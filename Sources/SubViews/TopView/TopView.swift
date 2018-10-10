//
//  TopView.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

protocol TopViewDelegate {
    func topDidScroll(offset: CGFloat)
}

class TopView: UIView {
    
    private var collectionViewTop: UICollectionView!
    private var collectionViewMiddleImage: UICollectionView!
    private var collectionViewMiddleText: UICollectionView!
    private var sizingView: SizingView = SizingView()
    
    private var images: [UIImage] = []
    private var titles: [String] = []
    
    private var direction: UICollectionView.ScrollDirection = .horizontal
    
    var delegate: TopViewDelegate?
    
    var isScrollingEnabled: Bool = true {
        didSet {
            collectionViewTop.isScrollEnabled = isScrollingEnabled
            collectionViewMiddleImage.isScrollEnabled = isScrollingEnabled
            collectionViewMiddleText.isScrollEnabled = isScrollingEnabled
        }
    }
    
    var currentIndex: Int = 0 {
        didSet {
            updateSizingView(index: currentIndex)
        }
    }
    
    var currentOffset: CGFloat = 0.0 {
        didSet {
            collectionViewTop.contentOffset.x = currentOffset
            collectionViewMiddleImage.contentOffset.x = currentOffset
            collectionViewMiddleText.contentOffset.x = currentOffset
            updateIndex()
        }
    }
    
    var size: CGFloat = Settings.Sizes.navbarSize {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        hideSizingView()
        setupCollections()
        setCollectionsLayout()
    }
  
    private func addSubviews() {
        addSubview(collectionViewTop)
        addSubview(collectionViewMiddleImage)
        addSubview(collectionViewMiddleText)
        addSubview(sizingView)
    }
    
    private func setupCollections() {
        collectionViewTop = UICollectionView(frame : .zero, collectionViewLayout : AnimatedCollectionViewLayout())
        collectionViewMiddleImage = UICollectionView(frame : .zero, collectionViewLayout : AnimatedCollectionViewLayout())
        collectionViewMiddleText = UICollectionView(frame : .zero, collectionViewLayout : AnimatedCollectionViewLayout())
        
        let collections = [collectionViewTop, collectionViewMiddleImage, collectionViewMiddleText]
        
        for collection in collections {
            collection?.delegate = self
            collection?.dataSource = self
            collection?.backgroundView?.backgroundColor = .clear
            collection?.backgroundColor = .clear
            collection?.showsHorizontalScrollIndicator = false
            collection?.showsVerticalScrollIndicator   = false
        }
        
        collectionViewTop.isHidden = false
        collectionViewTop.register(TopViewCellOne.self, forCellWithReuseIdentifier: String(describing: TopViewCellOne.self))
        
        
        collectionViewMiddleImage.isHidden = true
        collectionViewMiddleImage.register(TopViewCellTwo.self, forCellWithReuseIdentifier: String(describing: TopViewCellTwo.self))
        
        collectionViewMiddleText.isHidden = true
        collectionViewMiddleText.register(TopViewCellThree.self, forCellWithReuseIdentifier: String(describing: TopViewCellThree.self))
    }
    
    private func setCollectionsLayout() {
        if let layout = collectionViewTop?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = FadeAnimator()
            collectionViewTop?.isPagingEnabled = true
        }
        
        if let layout = collectionViewMiddleImage?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = FadeAnimator()
            collectionViewMiddleImage?.isPagingEnabled = true
        }
        
        if let layout = collectionViewMiddleText?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = MovementAnimator()
            collectionViewMiddleText?.isPagingEnabled = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = bounds.width
        
        sizingView.frame = CGRect(x: 0, y: 0, width: w, height: size)
        
        collectionViewTop.frame = CGRect(x: 0, y: 0, width: w, height: Settings.Sizes.navbarSize)
        collectionViewMiddleImage.frame = CGRect(x: 0, y: 0, width: w, height: Settings.Sizes.middleSize)
        collectionViewMiddleText.frame = CGRect(x: 0, y: 0, width: w, height: Settings.Sizes.middleSize)
    }
    
}

extension TopView {
    
    func setSizingViewHeight(height: CGFloat) {
        size = height
    }
    
    func hideSizingView() {
        sizingView.isHidden = true
    }
    
    func showSizingView() {
        sizingView.isHidden = false
    }
    
    func collapseSizingView() {
        sizingView.animateCollapse()
    }
    
    func toggleTopStateViews() {
        collectionViewTop.isHidden = false
        collectionViewMiddleImage.isHidden = true
        collectionViewMiddleText.isHidden = true
    }
    
    func toggleMiddleStateViews() {
        collectionViewTop.isHidden = true
        collectionViewMiddleImage.isHidden = false
        collectionViewMiddleText.isHidden = false
    }
    
    func toggleBottomStateViews() {
        collectionViewTop.isHidden = true
        collectionViewMiddleImage.isHidden = true
        collectionViewMiddleText.isHidden = true
    }
    
    func setSizingViewProgress(progress: CGFloat) {
        sizingView.progress = progress
    }
    
}

extension TopView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionViewTop:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TopViewCellOne.self), for: indexPath) as! TopViewCellOne
            cell.setData(title: titles[indexPath.row], image: images[indexPath.row])
            return cell
        case collectionViewMiddleImage:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TopViewCellTwo.self), for: indexPath) as! TopViewCellTwo
            cell.setImage(image: images[indexPath.row])
            return cell
        case collectionViewMiddleText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TopViewCellThree.self), for: indexPath) as! TopViewCellThree
            cell.setTitle(title: titles[indexPath.row])
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension TopView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateIndex()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        updateIndex()
    }
    
    func updateIndex() {
        currentIndex = Int(collectionViewMiddleImage.contentOffset.x / Settings.Sizes.screenWidth)
        guard let navView = superview as? NavigationView else { return }
        navView.currentIndex = currentIndex
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionViewMiddleText.isTracking {
            collectionViewTop.contentOffset.x = collectionViewMiddleText.contentOffset.x
            collectionViewMiddleImage.contentOffset.x = collectionViewMiddleText.contentOffset.x
            delegate?.topDidScroll(offset: collectionViewMiddleText.contentOffset.x)
        }
        if collectionViewMiddleText.isDragging {
            collectionViewTop.contentOffset.x = collectionViewMiddleText.contentOffset.x
            collectionViewMiddleImage.contentOffset.x = collectionViewMiddleText.contentOffset.x
            delegate?.topDidScroll(offset: collectionViewMiddleText.contentOffset.x)
        }
        if collectionViewMiddleText.isDecelerating {
            collectionViewTop.contentOffset.x = collectionViewMiddleText.contentOffset.x
            collectionViewMiddleImage.contentOffset.x = collectionViewMiddleText.contentOffset.x
            delegate?.topDidScroll(offset: collectionViewMiddleText.contentOffset.x)
        }
        
        if collectionViewTop.isTracking {
            collectionViewMiddleText.contentOffset.x = collectionViewTop.contentOffset.x
            collectionViewMiddleImage.contentOffset.x = collectionViewTop.contentOffset.x
            delegate?.topDidScroll(offset: collectionViewTop.contentOffset.x)
        }
        if collectionViewTop.isDragging {
            collectionViewMiddleText.contentOffset.x = collectionViewTop.contentOffset.x
            collectionViewMiddleImage.contentOffset.x = collectionViewTop.contentOffset.x
            delegate?.topDidScroll(offset: collectionViewTop.contentOffset.x)
        }
        if collectionViewTop.isDecelerating {
            collectionViewMiddleText.contentOffset.x = collectionViewTop.contentOffset.x
            collectionViewMiddleImage.contentOffset.x = collectionViewTop.contentOffset.x
            delegate?.topDidScroll(offset: collectionViewTop.contentOffset.x)
        }
    }
    
}

extension TopView {
    
    func setData(titles: [String], images: [UIImage]) {
        self.titles = titles
        self.images = images
        
        collectionViewTop.reloadData()
        collectionViewMiddleImage.reloadData()
        collectionViewMiddleText.reloadData()
        updateIndex()
    }
    
    private func updateSizingView(index: Int) {
        var previousTitle: String = ""
        var nextTitle: String = ""
        
        if index - 1 >= 0 {
            previousTitle = titles[index - 1]
        }
        if index + 1 <= titles.count - 1 {
            nextTitle = titles[index + 1]
        }
        
        sizingView.setData(title: titles[index],
                           image: images[index],
                           previousTitle: previousTitle,
                           nextTitle: nextTitle)
    }
    
    func updateOffsets() {
        let collectionContentOffset = CGPoint(x: CGFloat(currentIndex) * Settings.Sizes.screenWidth, y: 0)
        
        collectionViewTop.setContentOffset(collectionContentOffset, animated: false)
        collectionViewMiddleImage.setContentOffset(collectionContentOffset, animated: false)
        collectionViewMiddleText.setContentOffset(collectionContentOffset, animated: false)
    }
    
}

import UIKit

class AnimationView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AnimationMiddleViewDelegate, UIScrollViewDelegate {
  
  private var menuBtn: UIButton?
  
  private var collectionView: UICollectionView?
  private var middleView = AnimationMiddleView()
  private var scrollView = UIScrollView()
  
  private var hhh: CGFloat = 64
  private var collectionLayout = Layout()
  
  let dummyViews: [UIView] = [UIView(), UIView(), UIView(), UIView(), UIView(), UIView()]
  
  private var viewState: Int = 0 {
    didSet {
      let animationType = UIViewAnimationOptions.curveLinear
      switch viewState {
      case 0:
        self.hhh = 64
      case 1:
        self.hhh = self.bounds.size.height / 2 - 37.5
      case 2:
        self.hhh = self.bounds.size.height
      default:
        break
      }
      
      UIView.animate(withDuration: 0.35, delay: 0.0, options: animationType, animations: {
        self.collectionLayout.state = self.viewState
        self.setNeedsLayout()
        self.layoutIfNeeded()
      }) { (completed) in }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  private func configure() {
    self.backgroundColor = .yellow
    
    middleView.delegate = self
    
    collectionView                = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    collectionView?.clipsToBounds = true
    collectionView?.delegate      = self
    collectionView?.dataSource    = self
    collectionView?.register(Cell.self, forCellWithReuseIdentifier: "Cell")
    collectionView?.backgroundColor = .green
    collectionView?.contentInsetAdjustmentBehavior = .never
//    collectionView?.bounces = true
    
    collectionView?.backgroundView = CollectionUnderView()
    
    scrollView.backgroundColor = .red
    scrollView.isPagingEnabled = true
//    scrollView.bounces         = true
    scrollView.delegate = self
    
    menuBtn = UIButton(type: .custom)
    menuBtn?.setTitle("menu", for: .normal)
    menuBtn?.setTitleColor(.red, for: .normal)
    
    menuBtn?.addTarget(self, action: #selector(tapMenu), for: .touchUpInside)
    
    self.addSubview(collectionView!)
    self.addSubview(middleView)
    self.addSubview(scrollView)
    self.addSubview(menuBtn!)
    
    for view in dummyViews {
      view.backgroundColor = getRandomColor()
      scrollView.addSubview(view)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let w = self.bounds.size.width
    let h = self.bounds.size.height
    
    collectionView?.frame       = self.bounds
    collectionView?.contentSize = CGSize(width: 100.0, height: 100.0)

    middleView.frame            = CGRect(x: 0, y: hhh, width: w, height: 65)
    scrollView.frame            = CGRect(x: 0, y: middleView.frame.maxY, width: w, height: h - middleView.frame.maxY)
    scrollView.contentSize      = CGSize(width: w * CGFloat(dummyViews.count), height: scrollView.frame.height)
    
    for view in dummyViews {
      view.frame = CGRect(x: w * CGFloat(dummyViews.index(of: view)!), y: 0, width: w, height: scrollView.frame.size.height)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
    
    switch indexPath.row % 6 {
    case 0:
      cell.setData(title: "\(indexPath.row)", image: UIImage(named: "pic_agony")!)
      break
    case 1:
      cell.setData(title: "\(indexPath.row)", image: UIImage(named: "pic_depression")!)
      break
    case 2:
      cell.setData(title: "\(indexPath.row)", image: UIImage(named: "pic_gaming")!)
      break
    case 3:
      cell.setData(title: "\(indexPath.row)", image: UIImage(named: "pic_science")!)
      break
    case 4:
      cell.setData(title: "\(indexPath.row)", image: UIImage(named: "pic_tech")!)
      break
    case 5:
      cell.setData(title: "\(indexPath.row)", image: UIImage(named: "pic_movies")!)
      break
    default:
      break
    }
 
    cell.setState(state: viewState)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if viewState == 2 {
      self.collectionLayout.selectedIndex = indexPath.row
      
      self.moveUp()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    (cell as! Cell).setState(state: viewState)
  }
  
  internal func moveUp() {
    viewState -= 1
    
    if viewState < 0 {
      viewState = 0
    }

    for cell in (self.collectionView?.visibleCells)! {
      (cell as! Cell).setState(state: viewState)
    }
  }
  
  internal func moveDown() {
    viewState += 1
    if viewState > 2 {
      viewState = 2
    }
    
    for cell in (self.collectionView?.visibleCells)! {
      (cell as! Cell).setState(state: viewState)
    }
  }
  
  @objc func tapMenu() {
    viewState = 1
    viewState = 2
  }
  
  private func getRandomColor() -> UIColor{
    let red:CGFloat = CGFloat(drand48())
    let green:CGFloat = CGFloat(drand48())
    let blue:CGFloat = CGFloat(drand48())
    
    return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    if scrollView == collectionView {
//      self.synchronizeScrollView(self.scrollView, toScrollView: collectionView!)
//    } else if scrollView == self.scrollView {
//      self.synchronizeScrollView(collectionView!, toScrollView: self.scrollView)
//    }
  }
  
  func synchronizeScrollView(_ scrollViewToScroll: UIScrollView, toScrollView scrolledView: UIScrollView) {
    var offset = scrollViewToScroll.contentOffset
    offset.x = scrolledView.contentOffset.x
    
    scrollViewToScroll.setContentOffset(offset, animated: false)
  }
  
}

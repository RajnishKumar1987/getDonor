//
//  TopBannerTableViewCell.swift
//  GetDonor
//
//  Created by Rajnish kumar on 09/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit

enum CarouselType {
    case topBanner, carousel(title: String, cellType: HomeScreenCellType)
}

protocol CarouselTableViewCellDelegate: class{
    func didButtonPressed(at index:Int)
}

class CarouselTableViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bannerContainerView: UIView!
    weak var delegate: HomeScreenCellDelegate?
    @IBOutlet weak var containerViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lblTitle: UILabel!

    var timer: Timer!
    var currentSlide: Int = 0
    var model: [ContentDataModel] = []
    var currentXPosition: CGFloat!
    var slidePosition: Int = 0
    var slidesArray: [CarouselView] = []
    var cellWidth:CGFloat!
    var cellHeight: CGFloat!
    var lastContentOffset:CGPoint!
    var isAnimating:Bool = false
    var cellType: HomeScreenCellType!
    
    
    let scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.backgroundColor = UIColor.clear
        scrView.isPagingEnabled = true
        scrView.isDirectionalLockEnabled = true
        scrView.clipsToBounds = true
        scrView.bounces = false
        return scrView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title1)
        btnMore.titleLabel?.font = UIFont.fontWithTextStyle(textStyle: .title2)

        pageControl.currentPageIndicatorTintColor = UIColor.colorFor(component: .button)
    }
    
    func addScrollView() {
        scrollView.delegate = self
        self.bannerContainerView.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: cellHeight)
        
    }
    
    func setCellWidth() {
        cellWidth = UIScreen.main.bounds.width
    }
    func setCellHeight() {
        cellHeight = self.bounds.height - containerViewTopConstraints.constant
    }
    override func prepareForReuse() {
        if self.model.count > 1{
        self.timer.invalidate()
        self.timer = nil
        }
    }
    func startTimer() {
        
        guard self.timer == nil else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(animateScrollView), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func didMoreButtonPressed(_ sender: UIButton) {
       
        if let delegate = delegate {
            delegate.didMoreButtonPressed(at: self.cellType)
        }
    }
    func configureCell(with model:[ContentDataModel]?, and carouselType: CarouselType) {
        
        switch carouselType {
        case .carousel(let title, let cellType):
            containerViewTopConstraints.constant = 36
            self.lblTitle.text = title
            self.cellType = cellType
        default:
            containerViewTopConstraints.constant = 0
        }
        
        if let model = model{
            setCellWidth()
            setCellHeight()
            self.model = model
            if self.model.count == 2{
                self.model.append(model[0])
                self.model.append(model[1])
                generateSlides(model: self.model, shouldRecreateIndex: true)
            }
            else{
                generateSlides(model: self.model, shouldRecreateIndex: false)

            }
            pageControl.numberOfPages = model.count
            self.addScrollView()
            slidePosition = 0
            prepareSlide()
            scrollView.contentOffset = CGPoint(x: currentXPosition, y: 0)
            if self.model.count > 1{
                startTimer()
            }

        }
        
    }
    
    func generateSlides(model: [ContentDataModel], shouldRecreateIndex: Bool) {
        
        slidesArray.removeAll()
        
        for i in 0..<model.count {
            
            let banner = CarouselView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: cellHeight))
            banner.delegate = self
            if shouldRecreateIndex{
                banner.itemIndex = i%2
            }else{
                banner.itemIndex = i
            }
            let model = model[i]

            if let imageUrl = model.image {
                banner.imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "default"))
            }

            banner.lblTitle.text = model.title ?? ""
            banner.lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
            banner.imageView.makeCornerRadiusWithValue(10)
            banner.ingrediantView.round(corners: [.bottomLeft, .bottomRight], radius: 10)
            if let contentType = ContentType(rawValue: model.type!){
                if contentType != .video{
                    banner.playIcon.isHidden = true
                }
            }
            slidesArray.append(banner)
            
        }
        
    }
    
    
    func prepareSlide() {
        
        let currentSlide: CarouselView
        let nextSlide: CarouselView
        let previousSlide: CarouselView
        
        if slidePosition >= model.count || slidePosition < 0 {
            slidePosition = 0
            currentSlide = slidesArray[slidePosition]
        }
        else
        {
            currentSlide = slidesArray[slidePosition]
        }
        
        if (slidePosition - 1) < 0{
            previousSlide = slidesArray[slidesArray.count - 1]
        }else
        {
            previousSlide = slidesArray[slidePosition - 1]
            
        }
        
        if (slidePosition + 1) >= slidesArray.count {
            nextSlide = slidesArray[0]
        }else{
            nextSlide = slidesArray[slidePosition + 1]
        }
        
        let carosal:[CarouselView] = [previousSlide,currentSlide,nextSlide]
        
        scrollView.contentSize = CGSize(width: cellWidth * CGFloat(carosal.count), height: cellHeight)
        
        for i in 0..<carosal.count {
            
            carosal[i].frame = CGRect(x: CGFloat(i) * cellWidth, y: 0, width: cellWidth, height: cellHeight)
            scrollView.addSubview(carosal[i])
            
        }
        
        currentXPosition = currentSlide.frame.origin.x
        lastContentOffset = scrollView.contentOffset
        pageControl.currentPage = slidePosition
        
    }
    
    @objc func animateScrollView() {
        if slidesArray.count > 1 {
            isAnimating = true
            self.slidePosition += 1
            self.prepareSlide()
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            UIView.animate(withDuration: 0.8, animations: {
                self.scrollView.contentOffset = CGPoint(x: self.currentXPosition, y: 0)
            }, completion: { (completed) in
                self.isAnimating = false
            })
        }
    }
    
    
    func moveSlidePosition(){
        
        print("scrollView.contentOffset.x = \(scrollView.contentOffset.x)")
        print("lastContentOffset.x = \(lastContentOffset.x)")
        
        if(lastContentOffset.x < scrollView.contentOffset.x){
            print("scrolling right")
            self.slidePosition += 1
        }
        if(lastContentOffset.x > scrollView.contentOffset.x){
            print("scrolling left")
            self.slidePosition -= 1
            if (slidePosition < 0){
                slidePosition = slidesArray.count - 1
            }
        }
        print(slidePosition)
        self.prepareSlide()
        if !isAnimating{
            scrollView.contentOffset = CGPoint(x: currentXPosition, y: 0)
        }
        lastContentOffset = scrollView.contentOffset
    }
    
}

extension CarouselTableViewCell:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.model.count > 1{
        self.timer.invalidate()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.model.count > 1{
            self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(animateScrollView), userInfo: nil, repeats: true)
        }

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(!isAnimating){
            moveSlidePosition()
        }
    }
    
}

extension CarouselTableViewCell: CarouselTableViewCellDelegate{
    func didButtonPressed(at index: Int) {
        
        let dataModel = model[index]
        
        if let delegate = delegate  {
            delegate.didCellSelected(at: IndexPath(row: index, section: 0), with: HomeScreenCellType(rawValue: dataModel.type!)!)
            
            delegate.didCellSelected(at: IndexPath(row: index, section: 0), with: model[index])
        }
        
        
        print("Item selected at : \(index)")
    }
}

//
//  PageScrollView.swift
//  $Mate
//
//  Created by 郭振永 on 15/3/30.
//  Copyright (c) 2015年 guozy. All rights reserved.
//

import UIKit

class PageScrollView: UIView, UIScrollViewDelegate {
    var currentPageIndex: Int = 0
    var titles = [String]()
    var noteTitle = UILabel()
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = UIColor.clearColor()
    }
    
    init(frame: CGRect, views: Array<UIView>, titles: Array<String>){
        super.init(frame: frame)
        self.titles = titles
        self.frame = frame
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.clearColor()
        
        let count = views.count
        
        var scrollView = UIScrollView(frame: CGRectMake(0, 0, frame.width, frame.height))
        scrollView.contentSize = CGSizeMake(frame.width * CGFloat(count), frame.height)
        scrollView.setContentOffset(CGPointMake(frame.width, 0), animated: false)
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        
        for (var i = 0; i < count; i++) {
            views[i].frame = CGRectMake(frame.width * CGFloat(i), 0, frame.width, frame.height)
            scrollView.addSubview(views[i])
        }
        
        self.scrollView = scrollView
        self.addSubview(scrollView)
        
        //title
        var noteView = UIView(frame: CGRectMake(0, self.bounds.size.height - 33.0, frame.width, 33))
        noteView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        
        let pageControlWidth = CGFloat(count - 2) * 10.0 + 40.0
        let pageControlHeight = CGFloat(20.0)
        var pageControl = UIPageControl(frame: CGRectMake(frame.width - pageControlWidth, 6, pageControlWidth, pageControlHeight))
        pageControl.currentPage = 0;
        pageControl.numberOfPages = count - 2
        self.pageControl = pageControl
        noteView.addSubview(pageControl)
        
        var noteTitle = UILabel(frame: CGRectMake(5, 6, frame.width - pageControlWidth, 20))
        noteTitle.text = titles[0]
        noteTitle.backgroundColor = UIColor.clearColor()
        noteTitle.font = UIFont.systemFontOfSize(13)
        self.noteTitle = noteTitle
        noteView.addSubview(noteTitle)
        
        self.addSubview(noteView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = frame.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth)) + 1
        currentPageIndex = page
        pageControl.currentPage = (page - 1)
        var titleIndex = page - 1
        if (titleIndex == titles.count) {
            titleIndex = 0
        }
        if (titleIndex < 0){
            titleIndex = titles.count - 1
        }
        noteTitle.text = titles[titleIndex]
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(currentPageIndex == 0) {
            scrollView.setContentOffset(CGPointMake(CGFloat(titles.count) * frame.width, 0), animated: false)
        }
        if(currentPageIndex == titles.count + 1) {
            scrollView.setContentOffset(CGPointMake(frame.width, 0), animated: false)
        }
    }
    
    func imagePressed(sender: UITapGestureRecognizer) {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

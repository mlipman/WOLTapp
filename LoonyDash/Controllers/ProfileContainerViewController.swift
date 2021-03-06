//
//  UserProfileContainerViewController.swift
//  LoonyDash
//
//  Created by ming yeow ng on 6/22/15.
//  Copyright © 2015 LooneyDash. All rights reserved.
//

import UIKit

class ProfileContainerViewController: UIPageViewController, UIPageViewControllerDataSource  {
    
    var pages: [UIViewController] = []
    var setCompletedVc: UINavigationController!
    var personalRecordsVc: UINavigationController!
    var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageControl()
        setCompletedVc = UIStoryboard(name: "Profile", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("SetsCompletedNavViewController") as!UINavigationController
        setCompletedVc.navigationBar.barTintColor = UIColor.blackColor()
        setCompletedVc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        setCompletedVc.navigationBar.tintColor = UIColor.whiteColor()

        personalRecordsVc = UIStoryboard(name: "Profile", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PersonalRecordsNavViewController") as!UINavigationController
        personalRecordsVc.navigationBar.barTintColor = UIColor.blackColor()
        personalRecordsVc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        personalRecordsVc.navigationBar.tintColor = UIColor.whiteColor()
        
        pages = [setCompletedVc, personalRecordsVc]
        dataSource = self
        setViewControllers([setCompletedVc], direction: .Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController == pages[0] {
            pageControl.currentPage = 1
            return pages[1]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController == pages[1] {
            pageControl.currentPage = 0
            return pages[0]
        } else {
            return nil
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.frame = CGRectMake(self.view.frame.width/2-50, 75, 100, 10)
        pageControl.numberOfPages = 2;
        pageControl.currentPage = 0;
        pageControl.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(pageControl)
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.grayColor()        
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
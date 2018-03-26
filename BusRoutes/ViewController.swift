//
//  ViewController.swift
//  BusRoutes
//
//  Created by Sharath Hiremath on 3/23/18.
//  Copyright © 2018 Sharath Hiremath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //MARK: Properties
    var routes = [Route]()
    var currentRouteIndex = 0
    var pageViewController : UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func swipeLeft(sender: AnyObject) {
        print("SWipe left")
    }
    
    @IBAction func swiped(sender: AnyObject) {
        self.pageViewController.view .removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
        reset()
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return routes.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentRouteIndex
    }
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = (viewController as? RouteDetailsTableViewController)?.routeIndex! ?? 0
        if(index <= 0){
            return nil
        }
        let prevIndex = index - 1
        return self.viewControllerAtIndex(index: prevIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as? RouteDetailsTableViewController)?.routeIndex! ?? 0
        let nextIndex = index + 1
        if(nextIndex >= self.routes.count){
            return nil
        }
        return self.viewControllerAtIndex(index: nextIndex)
        
    }
    
    
    //MARK: Private Methods
    private func reset() {
        // Getting the page View controller
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        self.pageViewController.dataSource = self
        
        let routeDetailsViewController = self.viewControllerAtIndex(index: currentRouteIndex)
        self.pageViewController.setViewControllers([routeDetailsViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    }
    
    private func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((self.routes.count == 0) || (index >= self.routes.count)) {
            return nil
        }
        let routeDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "RouteDetailsTableViewController") as? RouteDetailsTableViewController
    
        routeDetailsViewController?.route = self.routes[index]
        routeDetailsViewController?.routeIndex = index
        return routeDetailsViewController
    }

}

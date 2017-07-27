//
//  EventTopViewController.swift
//  zenigame
//
//  Created by 笹野駿 on 2017/06/19.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

class EventTopViewController: BaseViewController {

    @IBOutlet fileprivate weak var headerView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var bannerView: UIView!
    @IBOutlet fileprivate weak var pageControl: UIPageControl!

    var pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    var events = [Event]()
    var constraintsAdded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.layer.borderColor = UIColor.black.cgColor
        headerView.layer.borderWidth = 1
        titleLabel.text = "次回配信は12/12 18:00~"

        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = UIColor.white

        pageController.delegate = self
        pageController.dataSource = self

        bannerView.addSubview(pageController.view)
        view.setNeedsUpdateConstraints()

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func loadData() {
        var event = Event()
        event.id = 0
        event.title = "バナー1"
        event.thumbnailUrl = "https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/1570189/680/453/m1/fpnw/wm1/hr5og7j496jqmmvrui2ifxpt19lyxfqpyjjxgcefpo2n2bvequihvqqv4zimgcad-.jpg?1471580863&s=a0d47154d0735010085c8f1d2438568d"
        events.append(event)

        event = Event()
        event.id = 1
        event.title = "バナー2"
        event.thumbnailUrl = "https://image.freepik.com/free-vector/promotion-vector-background_21-1507.jpg"
        events.append(event)

        event = Event()
        event.id = 2
        event.title = "バナー3"
        event.thumbnailUrl = "https://www.rumahweb.com/wp-content/uploads/2016/01/background-promo-copy.jpg"
        events.append(event)

        event = Event()
        event.id = 3
        event.title = "バナー4"
        event.thumbnailUrl = "http://images.freeimages.com/images/premium/previews/3209/32092780-new-year-sales-promotion-background.jpg"
        events.append(event)

        pageControl.numberOfPages = events.count

        let storyboard = UIStoryboard(name: "Banner", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "BannerViewController") as? BannerViewController {

            if !events.isEmpty {
                viewController.bindingData(event: events[0])
            }

            pageController.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
            pageController.didMove(toParentViewController: self)
        }
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        if !constraintsAdded {
            constraintsAdded = true

            pageController.view.autoPinEdge(toSuperviewEdge: .top)
            pageController.view.autoPinEdge(toSuperviewEdge: .bottom)
            pageController.view.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            pageController.view.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        }
    }
}

extension EventTopViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let currentEvent = (viewController as? BannerViewController)?.event
        if let event = currentEvent {
            let currentIndex = events.index(of: event)

            if let index = currentIndex {
                let storyboard = UIStoryboard(name: "Banner", bundle: nil)
                if let viewController = storyboard.instantiateViewController(withIdentifier: "BannerViewController") as? BannerViewController {
                    if index > 0 {
                        viewController.bindingData(event: events[index - 1])
                    } else {
                        viewController.bindingData(event: events[events.count - 1])
                    }
                    return viewController
                }
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let currentEvent = (viewController as? BannerViewController)?.event
        if let event = currentEvent {
            let currentIndex = events.index(of: event)

            if let index = currentIndex {
                let storyboard = UIStoryboard(name: "Banner", bundle: nil)
                if let viewController = storyboard.instantiateViewController(withIdentifier: "BannerViewController") as? BannerViewController {
                    if index < events.count - 1 {
                        viewController.bindingData(event: events[index + 1])
                    } else {
                        viewController.bindingData(event: events[0])
                    }
                    return viewController
                }
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if !completed {
            return
        }

        if let event = (pageViewController.viewControllers?.first as? BannerViewController)?.event {
            let currentIndex = events.index(of: event)

            if let index = currentIndex {
                self.pageControl.currentPage = index
            }
        }
    }
}

extension EventTopViewController: UIPageViewControllerDelegate {
}

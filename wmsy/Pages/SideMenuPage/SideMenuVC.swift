//
//  SideMenuVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class SideMenuVC: MenuViewController {
//    var viewIsVisible: Bool = true
//    override var prefersStatusBarHidden: Bool {
//        return !viewIsVisible
//    }
    var newMenu: MenuCollectionViewWrapper!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        newMenu = MenuCollectionViewWrapper(frame: menuScreen.frame)
        newMenu.menuPagesCollectionView.dataSource = self
        newMenu.menuPagesCollectionView.delegate = self
//        newMenu.backgroundColor = Stylesheet.Colors.WMSYMummysTomb
        menuScreen.addSubview(newMenu)
        newMenu.snp.makeConstraints { (make) in
            make.edges.equalTo(menuScreen)
        }
//        newMenu = MenuCollectionViewWrapper(frame: view.frame)
//        view.insertSubview(newMenu, belowSubview: snapShotOfMenuedViewController)
//        view.bringSubview(toFront: snapShotOfMenuedViewController)
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print(newMenu.bounds.height)
//        newMenu.layoutStuff()
//    }
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        print(newMenu.bounds.height)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewIsVisible = true
//        UIView.animate(withDuration: 0.5) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.viewIsVisible = true
//        UIView.animate(withDuration: 0.1) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }
//        navigationController.set
//        super.viewDidAppear(animated)
//        print(newMenu.bounds.height)
//        newMenu.layoutStuff()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        viewIsVisible = false
//        prefersStatusBarHidden = false
    }
    private var lastContentOffset: CGFloat = 0
}

extension SideMenuVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewWrapper.pageOneIdentifier, for: indexPath) as! MenuProfileView
            cell.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
            cell.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
            cell.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewWrapper.pageTwoIdentifier, for: indexPath) as! MenuWhimsView
            cell.whimsTableView.dataSource = self
            cell.whimsTableView.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return menuScreen.bounds.size
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            // move up
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            // move down
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let targetContentOffset = scrollView.contentOffset
////        float pageWidth = (float)self.articlesCollectionView.bounds.size.width;
//        let pageWidth = newMenu.menuPagesCollectionView.bounds.size.width
////        int minSpace = 10;
//        let minSpace: CGFloat = 10
////
////        int cellToSwipe = (scrollView.contentOffset.x)/(pageWidth + minSpace) + 0.5; // cell width + min spacing for lines
//        var cellToSwipe = (scrollView.contentOffset.x) / (pageWidth + minSpace) + 0.5
////        if (cellToSwipe < 0) {
////            cellToSwipe = 0;
////        } else if (cellToSwipe >= self.articles.count) {
////            cellToSwipe = self.articles.count - 1;
////        }
//        if cellToSwipe < 0 {
//            cellToSwipe = 0
//        } else if cellToSwipe >= 2 { // should represent datasource.count
//            cellToSwipe = 1 // should be last index of datasource
//        }
//        newMenu.menuPagesCollectionView.scrollToItem(at: IndexPath.init(row: Int(cellToSwipe), section: 0), at: .left, animated: true)
////        [self.articlesCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

extension SideMenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Hosts and Guest Chats
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuWhimsView.headerIdentifier) as! MenuWhimsHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0..<100:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuWhimsView.cellIdentifier, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


//
//  IntroViewController.swift
//  Call Inspector
//
//  Created by Jurica Mlinaric on 28/10/2018.
//  Copyright © 2018 Jurica Mlinaric. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var introCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnDone: UIButton!
    
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introCollectionView.dataSource = self
        introCollectionView.delegate = self
        
        introCollectionView.register(UINib(nibName: "IntroCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        pageControl.numberOfPages = Data.introTexts.count
    }
    
    @IBAction func btnDoneAction(_ sender: UIButton) {
        
        let defaults = UserDefaults.init(suiteName: Constants.USER_DEFAULTS)
        defaults?.set(true, forKey: Constants.FIRST_TIME)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        if self.navigationController != nil {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    // CollectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.introTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: IntroCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! IntroCell
        
        cell.label.text = Data.introTexts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.introCollectionView.bounds.width , height: self.introCollectionView.bounds.height)
        
    }
    
    // ScrollView delegate methods
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(self.introCollectionView.contentOffset.x / self.introCollectionView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
        if Int(pageNumber) == Data.introTexts.count - 1 {
            self.btnDone.isHidden = false
        }
    }

}

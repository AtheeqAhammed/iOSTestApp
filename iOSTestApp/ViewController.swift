//
//  ViewController.swift
//  iOSTestApp
//
//  Created by Ateeq Ahmed on 02/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    var images = ["snow", "bridge", "river", "mountain", "snow", "bridge", "river", "mountain", "bridge", "river"]
    
    let items = ["apple", "banana", "orange", "blueberry"]
    
    var previousOffsetState: CGFloat = 0

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var pageControlHeight: NSLayoutConstraint!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        floatingButton()
        
        pageControl.numberOfPages = images.count
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        collectionCell.imageOutlet.image = UIImage(named: images[indexPath.row])
        
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        itemCell.layer.borderColor = UIColor.white.cgColor
        itemCell.layer.borderWidth = 3
        itemCell.itemImage.image = UIImage(named: images[indexPath.row])
        
        return itemCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (200) {
            viewHeight.constant = 0
        }
        let offsetDiff = previousOffsetState - scrollView.contentOffset.y
        previousOffsetState = scrollView.contentOffset.y
        
        var newHeight = viewHeight.constant + offsetDiff
        viewHeight.constant = newHeight
        
        if scrollView.contentOffset.y > (25) {
            pageControlHeight.constant = 0
        }
        var newHeightPC = pageControlHeight.constant + offsetDiff
        pageControlHeight.constant = newHeightPC
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }
}

extension ViewController {
    
    func floatingButton()
    {
        let floatingButton = UIButton()
        floatingButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        floatingButton.tintColor = .white
        floatingButton.backgroundColor = .systemBlue
        floatingButton.layer.cornerRadius = 25
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        floatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true

        floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        
        floatingButton.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
    }
    
    @objc func showBottomSheet() {
            let bottomSheetVC = BottomSheetViewController()
            bottomSheetVC.items = items
            bottomSheetVC.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = bottomSheetVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
            }
        } else {
            // Fallback on earlier versions
        }
            present(bottomSheetVC, animated: true, completion: nil)
        }
}

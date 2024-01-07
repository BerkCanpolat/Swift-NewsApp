//
//  ViewController.swift
//  NewsApp
//
//  Created by Berk Canpolat on 7.01.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var newsModel = [NewsModel]()
    var viewModel = NewsViewModel()
    var dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getData()
        viewModel.viewNewsData()
    }
    
    func getData() {
        viewModel.loading.bind(to: indicator.rx.isAnimating).disposed(by: dispose)
        viewModel.error.observe(on: MainScheduler.asyncInstance).subscribe { error in
            print(error)
        }.disposed(by: dispose)
        viewModel.newsModel.observe(on: MainScheduler.asyncInstance).subscribe { list in
            self.newsModel = list
            self.collectionView.reloadData()
        }.disposed(by: dispose)
    }


}



extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let news = newsModel[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCollectionViewCell
        
        cell.newsLabel.text = news.title
        cell.newsTime.text = news.publishedAt
        cell.newsImage.sd_setImage(with: URL(string: news.urlToImage!))
        
        cell.layer.cornerRadius = 20
        cell.newsImage.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toNews", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toNews" {
            let gidilecekVC = segue.destination as! NewsDetailsVC
            
            gidilecekVC.news = newsModel[indeks!]
        }
    }
    
    
    
}

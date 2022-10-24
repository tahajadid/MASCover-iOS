//
//  WallpapersViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 22/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import Lottie

class WallpapersViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var centerBottom: UIView!
    @IBOutlet weak var leftBottom: UIView!
    @IBOutlet weak var rightBottom: UIView!
    @IBOutlet weak var wallpaperCollection: UICollectionView!
    @IBOutlet weak var wallpaperCollectionViewFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var backView: UIView!
    
    var idCategorie : String = ""
    var allWallpapers:[Wallpaper] = [Wallpaper]()
    private var myAnimationView: AnimationView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)

        drawCircles()
        drawTopAndBottom()
        initLoader()
        initAction()
                
        fetchData()
        
    }

    
    func initAction(){
        let gestureBack = UITapGestureRecognizer(target: self, action:  #selector (self.backAction (_:)))
        self.backView.addGestureRecognizer(gestureBack)
    }
    
    func initLoader(){
        myAnimationView = .init(name: "loading")
        myAnimationView!.frame = animatedView.bounds
        myAnimationView!.contentMode = .scaleAspectFill
        myAnimationView!.loopMode = .repeat(1.0)
        animatedView.addSubview(myAnimationView!)
        myAnimationView!.play()
    }
    
    private func initCollectionView() {
        wallpaperCollectionViewFlow.collectionView?.delegate = self
        let nib = UINib(nibName: "CustomWallpaperCell", bundle: nil)
        wallpaperCollection.register(nib, forCellWithReuseIdentifier: "CustomWallpaperCell")
        wallpaperCollection.dataSource = self
    }
    
    
    @objc func backAction(_ sender:UITapGestureRecognizer){
        // do other task
        let homeViewController = HomeViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(homeViewController, animated: true)
            }
        }
    }
    
    func fetchData(){
        
        let db = Firestore.firestore()

      
        db.collection("wallpaper")
            .whereField("idCategorie", isEqualTo: self.idCategorie)
            .getDocuments() {
                (querySnapshot, err) in
                    if let err = err {
                        print("-- Error getting documents: \(err)")
                    } else {
                        var index = 0
                        for document in querySnapshot!.documents {
                            print("-- \(document.documentID) => \(document.data())")
                            self.allWallpapers.insert(
                                Wallpaper(
                                    idWallpaper: document.data()["idWallpaper"] as? String ?? "",
                                    idCategorie: document.data()["idCategorie"] as? String ?? "",
                                    numberDislike: document.data()["numberDislike"] as? Int ?? 0,
                                    numberLike: document.data()["numberLike"] as? Int ?? 0,
                                    numberDownload: document.data()["numberDownload"] as? Int ?? 0,
                                    pathPoster: document.data()["pathPoster"] as? String ?? ""),
                                at: index)
                            index+=1
                        }
                        
                        // Reload Data
                        DispatchQueue.main.async {

                            self.animatedView.isHidden = true
                            self.initCollectionView()
                            /*
                            self.categorieTable.register(CategorieCell.nib(), forCellReuseIdentifier: CategorieCell.nibname)
                            self.wallpaperCollection.delegate = self
                            self.wallpaperCollection.dataSource = self
                            
                            self.wallpaperCollection.reloadData()
                        */
                             }
                    }
            }
        
        
    }
    
    func drawCircles(){
        self.centerBottom.layer.borderWidth = 3
        self.centerBottom.layer.borderColor = UIColor.white.cgColor
        self.centerBottom.layer.cornerRadius = self.centerBottom.frame.width / 2
        
        self.rightBottom.layer.borderWidth = 3
        self.rightBottom.layer.borderColor = UIColor.white.cgColor
        self.rightBottom.layer.cornerRadius = self.rightBottom.frame.width / 2
        
        self.leftBottom.layer.borderWidth = 3
        self.leftBottom.layer.borderColor = UIColor.white.cgColor
        self.leftBottom.layer.cornerRadius = self.leftBottom.frame.width / 2

    }
    
    func drawTopAndBottom(){
        self.topView.clipsToBounds = true
        self.topView.layer.cornerRadius = 20
        self.topView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        self.bottomView.clipsToBounds = true
        self.bottomView.layer.cornerRadius = 20
        self.bottomView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
    }
    
}

extension WallpapersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allWallpapers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomWallpaperCell", for: indexPath) as? CustomWallpaperCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.setImage(self.allWallpapers[indexPath.item].pathPoster ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let detailViewController = DetailViewController()
        detailViewController.pathWallpaper = allWallpapers[indexPath.row].pathPoster ?? ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(detailViewController, animated: true)
            }
        }
        
    }
}

extension WallpapersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 10, height: self.view.frame.height/3 - 10)
    }
}

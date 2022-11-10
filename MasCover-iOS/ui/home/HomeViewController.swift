//
//  HomeViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 16/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import Lottie
import AVFoundation

class HomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var categorieTable: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var centerBottom: UIView!
    @IBOutlet weak var leftBottom: UIView!
    @IBOutlet weak var rightBottom: UIView!
    @IBOutlet weak var flashView: UIView!
    @IBOutlet weak var yellowView: UIView!
    
    @IBOutlet weak var flashImage: UIImageView!
    
    private var myAnimationView: AnimationView?

    private var isOn = false
    var allCategories:[Categorie] = [Categorie]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        initViews()
        
        self.categorieTable.backgroundColor = UIColor.clear

        
        //FirebaseApp.configure()
        fetchBook()
    }
    
    func initViews(){
        
        drawCircles()
        drawTopAndBottom()
        
        myAnimationView = .init(name: "loading")
        myAnimationView!.frame = animatedView.bounds
        myAnimationView!.contentMode = .scaleAspectFill
        myAnimationView!.loopMode = .repeat(1.0)
        animatedView.addSubview(myAnimationView!)
        myAnimationView!.play()

        
        // Eliminate the hedear space inside TableView
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.categorieTable.tableHeaderView = UIView(frame: frame)
        
        // Add listener to setting
        let gestureSetting = UITapGestureRecognizer(target: self, action:  #selector (self.settingAction (_:)))
        self.rightBottom.addGestureRecognizer(gestureSetting)
        
        // Add listener to favorite
        let gestureFavorite = UITapGestureRecognizer(target: self, action:  #selector (self.favoriteAction (_:)))
        self.leftBottom.addGestureRecognizer(gestureFavorite)
        
        // Add listener to yellowScreen
        let gestureYellow = UITapGestureRecognizer(target: self, action:  #selector (self.yellowAction (_:)))
        self.yellowView.addGestureRecognizer(gestureYellow)
        
        // Add listener to flashView
        let gestureFlash = UITapGestureRecognizer(target: self, action:  #selector (self.flashAction (_:)))
        self.flashView.addGestureRecognizer(gestureFlash)
        
        flashView.isUserInteractionEnabled = true
        yellowView.isUserInteractionEnabled = true


    }
    
    
    func toggleTorch(on: Bool) {
        guard
            let device = AVCaptureDevice.default(for: AVMediaType.video),
            device.hasTorch
        else { return }

        do {
            try device.lockForConfiguration()
            device.torchMode = on ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used")
        }
    }
    
    
    @objc func settingAction(_ sender:UITapGestureRecognizer){
        // do other task
        let settingViewController = SettingViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(settingViewController, animated: false)
            }
        }
    }
    
    @objc func yellowAction(_ sender:UITapGestureRecognizer){
        // do other task
        let yellowScreenViewController = YellowScreenViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(yellowScreenViewController, animated: true)
            }
        }
    }
    
    @objc func flashAction(_ sender:UITapGestureRecognizer){
        isOn = !isOn
        toggleTorch(on: isOn)
        if(isOn) {
            flashImage.image = UIImage(named: "flash_fill")
            
        }else{
            flashImage.image = UIImage(named: "flash_empty")
        }
        
    }
    
    @objc func favoriteAction(_ sender:UITapGestureRecognizer){
        // do other task
        let favoriteViewController = FavoriteViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(favoriteViewController, animated: false)
            }
        }
    }
    
    
    private func fetchBook() {
        
        let db = Firestore.firestore()

      
        db.collection("categorie").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("-- Error getting documents: \(err)")
            } else {
                var index = 0
                for document in querySnapshot!.documents {
                    print("-- \(document.documentID) => \(document.data())")
                    self.allCategories.insert(
                        Categorie(
                            weight: document.data()["weight"] as? Int ?? 0,
                            idCategorie: document.data()["idCategorie"] as? String ?? "",
                            title: document.data()["title"] as? String ?? ""),
                        at: index)
                    index+=1
                }
                
                // Reload Data
                DispatchQueue.main.async {

                    self.animatedView.isHidden = true
                    
                    self.categorieTable.register(CategorieCell.nib(), forCellReuseIdentifier: CategorieCell.nibname)
                    self.categorieTable.delegate = self
                    self.categorieTable.dataSource = self
                    
                    self.categorieTable.reloadData()
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allCategories.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategorieCell.nibname, for: indexPath) as? CategorieCell
        
        cell?.categorieTitle.text = allCategories[indexPath.row].title ?? ""
        
        // upon the categorie id we set a background for each cell item
        switch allCategories[indexPath.row].idCategorie {
            case "masCategorie" : cell?.categoriImage.image = UIImage(named: "mas_cover")
            case "fatalTigersCategorie" : cell?.categoriImage.image = UIImage(named: "fatal_cover")
            case "fesCategorie" : cell?.categoriImage.image = UIImage(named: "fes_cover")
            case " footbalCategorie" : cell?.categoriImage.image = UIImage(named: "footbal_cover")
            default : cell?.categoriImage.image = UIImage(named: "mas_cover")
        }
        cell?.categoriImage.layer.cornerRadius = 10
        
        return cell ?? UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let wallpapersViewController = WallpapersViewController()
        //starViewController.valueAmount = listOfPrices[indexPath.item]
        wallpapersViewController.idCategorie = allCategories[indexPath.row].idCategorie ?? ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(wallpapersViewController, animated: true)
            }
        }
        
    }
    

}

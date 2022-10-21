//
//  HomeViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 16/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class HomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var categorieTable: UITableView!
    @IBOutlet weak var bottomView: UIView!
    
    var allCategories:[Categorie] = [Categorie]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        initViews()
        
        //FirebaseApp.configure()
        fetchBook()
    }
    
    func initViews(){
        

        self.topView.clipsToBounds = true
        self.topView.layer.cornerRadius = 20
        self.topView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        self.bottomView.clipsToBounds = true
        self.bottomView.layer.cornerRadius = 20
        self.bottomView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        

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

                    self.categorieTable.register(CategorieCell.nib(), forCellReuseIdentifier: CategorieCell.nibname)
                    self.categorieTable.delegate = self
                    self.categorieTable.dataSource = self
                    
                    self.categorieTable.reloadData()
                }
            }
        }
        
    }
    

}

extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategorieCell.nibname, for: indexPath) as? CategorieCell
        
        cell?.categorieTitle.text = allCategories[indexPath.row].title ?? ""
        cell?.categoriImage.layer.cornerRadius = 10
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 5

        return cellSpacingHeight
    }
    

}

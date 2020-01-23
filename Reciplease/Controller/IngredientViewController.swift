//
//  IngredientListViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 15/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {
    
    
    @IBOutlet weak var ingredientTableView: UITableView! { didSet { ingredientTableView.tableFooterView = UIView() } }
    @IBOutlet weak var addIngredientTF: UITextField!
    
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }
    
    @IBAction func addBt(_ sender: Any) {
        guard let ingredientToAdd = addIngredientTF.text else {return}
        coreDataManager?.addIngredient(name: ingredientToAdd)
        ingredientTableView.reloadData()
        addIngredientTF.text = ""
    }
    
    @IBAction func clearBt(_ sender: Any) {
        coreDataManager?.deleteAllIngredients()
        ingredientTableView.reloadData()
    }
    
    @IBAction func searchBt(_ sender: Any) {
    }
      
}

// MARK: - Table View

extension IngredientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = coreDataManager?.ingredients[indexPath.row].name
        return cell
    }
}


// MARK: - Dismiss Keyboard

extension IngredientViewController : UITextFieldDelegate {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        addIngredientTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
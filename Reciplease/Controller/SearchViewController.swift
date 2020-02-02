//
//  IngredientListViewController.swift
//  Reciplease
//
//  Created by Frederick Port on 15/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var ingredientsList = [String]()
    private let recipeService = RecipeService()
    private var recipesList = [Hit]()
    
    @IBOutlet weak var ingredientTableView: UITableView! { didSet { ingredientTableView.tableFooterView = UIView() } }
    
    @IBOutlet weak var addIngredientTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBt(_ sender: Any) {
        guard let ingredientToAdd = addIngredientTF.text else {return}
        if ingredientToAdd != "" {
            ingredientsList.append(ingredientToAdd)
            ingredientTableView.reloadData()
            addIngredientTF.text = ""
        }
    }
    
    @IBAction func clearBt(_ sender: Any) {
        self.ingredientsList = [String]()
        ingredientTableView.reloadData()
    }
    
    @IBAction func searchBt(_ sender: Any) {
        recipeService.getRecipe(text: ingredientsList) { result in
            switch result {
            case .success(let data):
                //print(data.count)
                self.recipesList = data.hits
                self.performSegue(withIdentifier: "RecipeListSegue", sender: self)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeListSegue" {
            guard let successVC = segue.destination as? RecipeTableViewController else { return }
            successVC.recipeList = recipesList
            //print(result.recipeList.count)
            
        }
    }
}

// MARK: - Table View DataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = ingredientsList[indexPath.row]
        return cell
    }
}

// MARK: - Table View Delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


// MARK: - Dismiss Keyboard

extension SearchViewController : UITextFieldDelegate {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        addIngredientTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

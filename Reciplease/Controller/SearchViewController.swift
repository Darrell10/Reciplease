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
    @IBOutlet weak var searchButton: CustomButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBt(_ sender: Any) {
        guard let ingredientToAdd = addIngredientTF.text else {return}
        if ingredientToAdd != "" {
            ingredientsList.append(ingredientToAdd)
            ingredientTableView.reloadData()
            addIngredientTF.text = ""
        } else {
            presentAlert(title: "error", message: "No ingredients added")
        }
    }
    
    @IBAction func clearBt(_ sender: Any) {
        self.ingredientsList = [String]()
        ingredientTableView.reloadData()
    }
    
    @IBAction func searchBt(_ sender: Any) {
        if ingredientsList.count == 0 {
            presentAlert(title: "Error", message: "Please add ingredients")
        } else {
            getRecipeList()
        }
    }
    
    private func getRecipeList() {
        toggleActivityIndicator(shown: true)
        recipeService.getRecipe(text: ingredientsList) { result in
            self.toggleActivityIndicator(shown: false)
            switch result {
            case .success(let data):
                self.recipesList = data.hits
                if data.count == 0 {
                    self.presentAlert(title: "No recipe Found", message: "Please add ingredients")
                } else {
                    self.performSegue(withIdentifier: "RecipeListSegue", sender: self)
                }
            case .failure(let error):
                self.presentAlert(title: "Error", message: "Data failed")
                print(error.localizedDescription)
            }
        }
    }
    
    private func toggleActivityIndicator (shown: Bool) {
        searchButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeListSegue" {
            guard let successVC = segue.destination as? RecipeTableViewController else { return }
            successVC.recipeList = recipesList
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

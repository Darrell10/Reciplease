import UIKit
import SOTabBar

class ViewController: SOTabBarController {
    
    override func loadView() {
        super.loadView()
        setupTapBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStoryBoard()
    }
    
    // MARK: - Setup
    
    private func setupStoryBoard() {
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "INGREDIENTS_ID")
        let favoriteStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FAVORITE_ID")
        homeStoryboard.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "ingredients"), selectedImage: UIImage(named: "ingredients_selected"))
        favoriteStoryboard.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite"), selectedImage: UIImage(named: "favorite_selected"))
        viewControllers = [homeStoryboard, favoriteStoryboard]
    }
    
    private func setupTapBar() {
        SOTabBarSetting.tabBarTintColor = #colorLiteral(red: 0.2686640322, green: 0.5821627378, blue: 0.3643993735, alpha: 1)
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
        SOTabBarSetting.tabBarHeight = 50.0
    }
    
}

//
//  HomeViewController.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/10/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//
import UIKit
class HomeViewController: UIViewController {
    
    var goToQodButton: UIButton!
    var goToSavedButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Set the navigation controller's title!
        title = "Home Screen"
        
        goToQodButton = UIButton()
        goToQodButton.translatesAutoresizingMaskIntoConstraints = false
        goToQodButton.setTitle("Quotes of the Day", for: .normal)
        goToQodButton.setTitleColor(.black, for: .normal)
        goToQodButton.addTarget(self, action: #selector(pushQuoteCategoryViewController), for: .touchUpInside)
        goToQodButton.titleLabel?.textAlignment = .center
        goToQodButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        goToQodButton.layer.borderWidth = 1.0
        goToQodButton.layer.cornerRadius = 20
        goToQodButton.layer.masksToBounds = true
        view.addSubview(goToQodButton)
        
        goToSavedButton = UIButton()
        goToSavedButton.translatesAutoresizingMaskIntoConstraints = false
        goToSavedButton.setTitle("Saved Quotes", for: .normal)
        goToSavedButton.setTitleColor(.black, for: .normal)
        goToSavedButton.layer.borderWidth = 1.0
        goToSavedButton.titleLabel?.textAlignment = .center
        goToSavedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        goToSavedButton.layer.cornerRadius = 20
        goToSavedButton.layer.masksToBounds = true
        goToSavedButton.addTarget(self, action: #selector(pushSavedQuotesViewController), for: .touchUpInside)
        view.addSubview(goToSavedButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButton))
        
        setupConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let textUnitString = defaults.string(forKey: UserDefaultsKey.textSize.rawValue), let textUnit =
            TextUnit(rawValue: textUnitString){
            
            if(textUnitString == "big"){
                goToQodButton.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
                goToSavedButton.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .bold)
            } else {
                goToQodButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                goToSavedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            }
            
        }
    }
    
    
    @objc func settingsButton(){
        let preferencesViewController = PreferencesViewController()
        self.navigationController?.pushViewController(preferencesViewController, animated: true)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            goToQodButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            goToQodButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -10),
            goToQodButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            goToQodButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            ])
        
        NSLayoutConstraint.activate([
            goToQodButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            goToQodButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -10),
            goToQodButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            goToQodButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            ])
        
        NSLayoutConstraint.activate([
            goToSavedButton.topAnchor.constraint(equalTo: goToQodButton.bottomAnchor, constant: 20),
            goToSavedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            goToSavedButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            goToSavedButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            ])
    }
    
    @objc func pushSavedQuotesViewController() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.goToSavedButton.backgroundColor = UIColor(red: 105/255.0, green: 105/255.0, blue: 105/255.0, alpha: 0.5)
            
        }, completion: {
            (finished: Bool) -> Void in
            
            //Once the label is completely invisible, set the text and fade it back in
            let searchViewController = SearchViewController()
            self.navigationController?.pushViewController(searchViewController, animated: true)
            self.goToSavedButton.backgroundColor = .white
            // Fade in
    })

        //let searchViewController = SearchViewController()
        //savedQuotesViewController.delegate = self
        //savedQuotesViewController.arenaName1 = goToQodButton.titleLabel?.text ?? "Red Square Arena"
        
        // This is how you push the NavViewController onto the navigation stack.
        // navigationController is optional because we don't know whether or not this ViewController
        // was implemented inside a NavigationController or not. (If it wasn't, nothing would happen)
        //
        // Now, NavViewController will be at the top of the navigation stack, and ViewController
        // will be at the bottom of the stack. The order of a stack is last-in-first-out (LIFO),
        // whereas queues are first-in-first-out (FIFO).
        //navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    @objc func pushQuoteCategoryViewController() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.goToQodButton.backgroundColor = UIColor(red: 105/255.0, green: 105/255.0, blue: 105/255.0, alpha: 0.5)
            
        }, completion: {
            (finished: Bool) -> Void in
            
            //Once the label is completely invisible, set the text and fade it back in
            let categoryViewController = CategoryViewController()
            self.navigationController?.pushViewController(categoryViewController, animated: true)
            self.goToQodButton.backgroundColor = .white
            // Fade in
        })
       
        // Here, we set the ModalViewController's delegate to our ViewController so it
        // can receive information from ModalViewController.
        //
        // This way, the modalViewController can call the method for when the button title changes
        // and the method will be called inside this view controller (self)
        
        //DISREGARD ABOVE********NOT MODAL VC
        
        //quoteCategoryViewController.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

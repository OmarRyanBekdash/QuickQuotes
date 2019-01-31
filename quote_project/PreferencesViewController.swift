//
//  PreferencesViewController.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/29/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//


import UIKit
import SnapKit

class PreferencesViewController: UIViewController {
    
    // MARK: - View vars
    var textSizeControl: UISegmentedControl!
//    var temperatureControl: UISegmentedControl!
//    var emojiControl: UISegmentedControl!
    
    var defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Preferences"
        
        // "Cancel" bar button
        let cancelBarItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelBarItem
        
        // "Save" bar button
        let saveBarItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePreferences))
        navigationItem.rightBarButtonItem = saveBarItem
        
        textSizeControl = UISegmentedControl()
        textSizeControl.insertSegment(withTitle: "Small", at: TextUnit.small.index, animated: true)
        textSizeControl.insertSegment(withTitle: "Big", at: TextUnit.big.index, animated: true)
        view.addSubview(textSizeControl)
        
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Distance
        if let textUnitString = defaults.string(forKey: UserDefaultsKey.textSize.rawValue), let unit = TextUnit(rawValue: textUnitString) {
            textSizeControl.selectedSegmentIndex = unit.index
        }

    }
    
    // MARK: - Constraints
    // Constraints constants
    var sideMargin: CGFloat = 40
    var interitemVerticalSpacing: CGFloat = 18
    
    func setUpConstraints() {
        textSizeControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(interitemVerticalSpacing)
            make.centerX.equalToSuperview()
        }
        
//        temperatureControl.snp.makeConstraints { make in
//            make.top.equalTo(textSizeControl.snp.bottom).offset(interitemVerticalSpacing)
//            make.centerX.equalToSuperview()
//        }
        
//        emojiControl.snp.makeConstraints { make in
//            make.top.equalTo(temperatureControl.snp.bottom).offset(interitemVerticalSpacing)
//            make.centerX.equalToSuperview()
//        }
    }
    
    // MARK: - Bar button actions
    @objc func cancel() {
        // Simply close the window when cancelled
        self.navigationController?.popViewController(animated: true)
//        let homeViewController = HomeViewController()
//        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    @objc func savePreferences() {
        // Save preferences and close the window
        
        let selectedTextUnit = TextUnit.allCases[textSizeControl.selectedSegmentIndex]
        defaults.set(selectedTextUnit.rawValue, forKey: UserDefaultsKey.textSize.rawValue)
//
//        let selectedTemperatureUnit = TemperatureUnit.allCases[temperatureControl.selectedSegmentIndex]
//        defaults.set(selectedTemperatureUnit.rawValue, forKey: UserDefaultsKey.temperature.rawValue)
//
//        if emojiControl.selectedSegmentIndex == 1 {
//            defaults.set(true, forKey: UserDefaultsKey.emoji.rawValue)
//        } else {
//            defaults.set(false, forKey: UserDefaultsKey.emoji.rawValue)
//        }
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true)
    }
    
}




//import UIKit
//
//class PreferencesViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

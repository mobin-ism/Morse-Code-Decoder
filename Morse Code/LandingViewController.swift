//
//  LandingViewController.swift
//  Morse Code
//
//  Created by Al Mobin on 13/7/18.
//  Copyright © 2018 Al Mobin. All rights reserved.
//

import UIKit
class LandingViewController: UIViewController {
    
    lazy var imageView : UIImageView = {
       var imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.image = #imageLiteral(resourceName: "morsecode")
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    lazy var goButton : UIButton = {
       
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Start Exploring", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(red:1.00, green:0.34, blue:0.13, alpha:1.0), for: .normal)
        button.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.22, green:0.56, blue:0.24, alpha:1.0)
        layout()
    }
    
    func layout() {
        setupImageView()
        setupGoButton()
    }
    
    func setupImageView() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func setupGoButton() {
        view.addSubview(goButton)
        goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        goButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        goButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func goButtonTapped() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}

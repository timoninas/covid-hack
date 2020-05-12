//
//  ViewController.swift
//  test_h
//
//  Created by Mac-HOME on 03.05.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//


import UIKit
import SpriteKit

class TestViewController: UIViewController {
    let tm = TestModel()

    let mySpacing: CGFloat = 30.0
    let questionLabel = UILabel()
    let counterLabel = UILabel()
    let progressView = UIProgressView(progressViewStyle: .default)
    let stackView = UIStackView()
    
    let informationIndentLabel = UILabel()
    let startIndentButton = UIButton()
    let informationRiscLabel = UILabel()
    let startRiscButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        view.backgroundColor = .white
        Utilities.configureStackView(stackView)
        view.addSubview(stackView)
        
        // StackView constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: mySpacing * 2).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: mySpacing).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -mySpacing).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -mySpacing * 4).isActive = true
        
        getTestInfo()
    }
    
    func getTestInfo() {
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        tm.reset()
        stackView.distribution = UIStackView.Distribution.fillEqually
        
        // Indentity test
        let stackViewIndent = UIStackView()
        Utilities.configureStackView(stackViewIndent)
        
        // Information about test
        Utilities.styleInformationLabel(informationIndentLabel)
        informationIndentLabel.text = "Пройдите опрос на наличие COVID-19"
        
        // Start test button
        Utilities.styleHollowButton(startIndentButton)
        startIndentButton.setTitle("Начать опрос", for: .normal)
        startIndentButton.addTarget(self, action: #selector(startIndentTest), for: .touchUpInside)
        
        // Constraints
        startIndentButton.translatesAutoresizingMaskIntoConstraints = false
        startIndentButton.addConstraint(NSLayoutConstraint(item: startIndentButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        
        stackViewIndent.addArrangedSubview(informationIndentLabel)
        stackViewIndent.addArrangedSubview(startIndentButton)
        
        // Risc test
        let stackViewRisc = UIStackView()
        Utilities.configureStackView(stackViewRisc)
        
        // Information about test
        Utilities.styleInformationLabel(informationRiscLabel)
        informationRiscLabel.text = "Пройдите опрос и узнайте находитесь ли вы в группе риска"
        
        // Start test button
        Utilities.styleHollowButton(startRiscButton)
        startRiscButton.setTitle("Начать опрос", for: .normal)
        startRiscButton.addTarget(self, action: #selector(startRiscTest), for: .touchUpInside)
        
        // Constraints
        startRiscButton.translatesAutoresizingMaskIntoConstraints = false
        startRiscButton.addConstraint(NSLayoutConstraint(item: startRiscButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        
        stackViewRisc.addArrangedSubview(informationRiscLabel)
        stackViewRisc.addArrangedSubview(startRiscButton)
        
        stackView.addArrangedSubview(stackViewIndent)
        stackView.addArrangedSubview(stackViewRisc)
    }
    
    @objc func startIndentTest() {
        tm.startIndentTest()
        startTest()
    }
    
    @objc func startRiscTest() {
        tm.startRiskTest()
        startTest()
    }
    
    func startTest() {
        stackView.distribution = UIStackView.Distribution.fill
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        
        // Progress label
        counterLabel.textAlignment = .center
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.addConstraint(NSLayoutConstraint(item: counterLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        stackView.addArrangedSubview(counterLabel)
        
        // Progress bar
        progressView.translatesAutoresizingMaskIntoConstraints = false
        let progressViewHeightConstraint = progressView.heightAnchor.constraint(equalToConstant: 10)
        progressView.addConstraints([progressViewHeightConstraint])
        stackView.addArrangedSubview(progressView)
        
        // Question
        Utilities.styleCardLabel(questionLabel)
        stackView.addArrangedSubview(questionLabel)
        
        // Answers
        let horizontalSv = UIStackView()
        horizontalSv.axis = .horizontal
        horizontalSv.alignment = .fill
        horizontalSv.distribution = .fillEqually
        horizontalSv.spacing = mySpacing
        horizontalSv.translatesAutoresizingMaskIntoConstraints = false
        horizontalSv.addConstraint(NSLayoutConstraint(item: horizontalSv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        
        // No button
        let buttonNo = UIButton()
        Utilities.styleHollowButton(buttonNo)
        buttonNo.setTitle("Нет", for: .normal)
        buttonNo.addTarget(self, action: #selector(onButtonNo), for: .touchUpInside)
        horizontalSv.addArrangedSubview(buttonNo)
        
        // Yes button
        let buttonYes = UIButton()
        Utilities.styleHollowButton(buttonYes)
        buttonYes.setTitle("Да", for: .normal)
        buttonYes.addTarget(self, action: #selector(onButtonYes), for: .touchUpInside)
        horizontalSv.addArrangedSubview(buttonYes)
        
        stackView.addArrangedSubview(horizontalSv)
        nextQuestion()
    }
    
    @objc func onButtonYes(buttonYes: UIButton) {
        Utilities.animationPulseButton(buttonYes)
        tm.answerYes()
        nextQuestion()
    }
    
    @objc func onButtonNo(buttonNo: UIButton) {
        Utilities.animationPulseButton(buttonNo)
        nextQuestion()
    }
    
    func nextQuestion(){
        progressView.progress = tm.getProgress()
        counterLabel.text = String(tm.questionInd) + " / " + String(tm.questions.count)
        Utilities.animationFlashLabel(counterLabel)
        
        if tm.questionInd == tm.questions.count {
            showResults()
            return
        }
        
        questionLabel.text = tm.getCurQuestion()
        tm.nextQuestion()
        
        UIView.transition(with: questionLabel, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func showResults() {
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        
        // Close button
        let horizontalSv = UIStackView()
        horizontalSv.axis = .horizontal
        horizontalSv.alignment = .fill
        horizontalSv.distribution = .fillEqually
        horizontalSv.spacing = mySpacing
        horizontalSv.translatesAutoresizingMaskIntoConstraints = false
        horizontalSv.addConstraint(NSLayoutConstraint(item: horizontalSv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        
        let gapl = UIStackView()
        horizontalSv.addArrangedSubview(gapl)
        
        let returnToInfoButton = UIButton()
        returnToInfoButton.setImage( UIImage.init(named: "close"), for: .normal)
        returnToInfoButton.addTarget(self, action: #selector(resetTest), for: .touchUpInside)
        horizontalSv.addArrangedSubview(returnToInfoButton)
        
        let gapr = UIStackView()
        horizontalSv.addArrangedSubview(gapr)
        stackView.addArrangedSubview(horizontalSv)
        
        // Test result
        let resultLabel = UILabel()
        Utilities.styleInformationLabel(resultLabel)
        resultLabel.text = tm.getAnswer()
        stackView.addArrangedSubview(resultLabel)
        
        let infoLabel = UILabel()
        Utilities.styleInformationLabel(infoLabel)
        infoLabel.text = tm.getWarning()
        infoLabel.font = UIFont(name:"AppleSDGothicNeo-Medium", size: 20.0)
        infoLabel.textColor = .gray
        stackView.addArrangedSubview(infoLabel)
        
        // Result description
        let descriptionLabel = UILabel()
        Utilities.styleInformationLabel(descriptionLabel)
        descriptionLabel.font = UIFont(name:"AppleSDGothicNeo-Medium", size: 20.0)
        descriptionLabel.text = tm.getDiscription()
        stackView.addArrangedSubview(descriptionLabel)
        
        // Link
        let linkText = UITextView()
        linkText.backgroundColor = .white
        linkText.textAlignment = .center
        linkText.font = UIFont(name:"AppleSDGothicNeo-Medium", size: 30.0)
        linkText.layer.shadowOffset = .zero
        linkText.layer.shadowColor = UIColor.gray.cgColor
        linkText.layer.shadowRadius = 5
        linkText.layer.shadowOpacity = 1
        
        linkText.isEditable = false;
        linkText.dataDetectorTypes = UIDataDetectorTypes.all;
        linkText.text = "http://onlinedoctor.ru"
        
        linkText.translatesAutoresizingMaskIntoConstraints = false
        linkText.addConstraint(NSLayoutConstraint(item: linkText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        
        stackView.addArrangedSubview(linkText)
    }
    
    @objc func resetTest(buttonNo: UIButton) {
        getTestInfo()
    }
}


//
//  GameConfigurationView.swift
//  BattleDrone
//
//  Created by Shawn Yapa on 9/1/21.
//

import Foundation
import UIKit

protocol GameConfigurationViewDelegate: AnyObject {
    func saveButtonPressed()
    func cancelButtonPressed()
}

class GameConfigurationView: UIView {
    
    var gameConfigurationViewDelegate: GameConfigurationViewDelegate?
    
    let stackView = UIStackView()
    
    let usernameView = UIView()
    let usernameLabel = UILabel()
    let usernameTextField = UITextField()
    
    let challengeTypeView = UIView()
    let challengeTypeSelector = UISegmentedControl(items: ["# of Hits","Max Time in Sec"])
    let challengeTypeLabel = UILabel()
    
    let hitsRequiredView = UIView()
    let hitsRequiredLabel = UILabel()
    let hitsRequiredIndicator = UIPickerView()
    let hitsRequiredRange: [Int] = Array(0...50)
    
    let maxTimeView = UIView()
    let maxTimeLabel = UILabel()
    let maxTimeIndicator = UIPickerView()
    let maxTimeRangeInSeconds: [Int] = Array(0...60)
    
    let targetMovementView = UIView()
    let targetMovementLabel = UILabel()
    let targetMovementSelector = UISegmentedControl(items: ["Fixed","Easy","Medium","Hard"])
    
    let saveButton = UIButton()
    let cancelButton = UIButton()
    
    func setupView() {
        backgroundColor = .white
        // StackView Setup
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        
        usernameView.translatesAutoresizingMaskIntoConstraints = false
        usernameView.backgroundColor = .lightGray
        stackView.addArrangedSubview(usernameView)
        usernameView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        usernameView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        usernameView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Username:"
        usernameLabel.textColor = .black
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Your Username"
        usernameView.addSubview(usernameLabel)
        usernameView.addSubview(usernameTextField)
        usernameLabel.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor, constant: 10).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: usernameView.centerYAnchor, constant: 0).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor, constant: -10).isActive = true
        usernameTextField.bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        
        challengeTypeView.translatesAutoresizingMaskIntoConstraints = false
        challengeTypeView.backgroundColor = .white
        stackView.addArrangedSubview(challengeTypeView)
        challengeTypeView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        challengeTypeView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        challengeTypeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        challengeTypeSelector.translatesAutoresizingMaskIntoConstraints = false
        challengeTypeView.addSubview(challengeTypeSelector)
        challengeTypeSelector.selectedSegmentIndex = 0
        challengeTypeSelector.addTarget(self, action: #selector(challengeTypeSelected(_:)), for: .valueChanged)
        challengeTypeSelector.bottomAnchor.constraint(equalTo: challengeTypeView.bottomAnchor, constant: -10).isActive = true
        challengeTypeSelector.centerXAnchor.constraint(equalTo: challengeTypeView.centerXAnchor, constant: 0).isActive = true
        
        hitsRequiredView.translatesAutoresizingMaskIntoConstraints = false
        hitsRequiredView.backgroundColor = .white
        stackView.addArrangedSubview(hitsRequiredView)
        hitsRequiredView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        hitsRequiredView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        hitsRequiredView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        hitsRequiredLabel.translatesAutoresizingMaskIntoConstraints = false
        hitsRequiredLabel.text = "Number of Hits:"
        hitsRequiredLabel.textColor = .black
        hitsRequiredView.addSubview(hitsRequiredLabel)
        hitsRequiredLabel.centerYAnchor.constraint(equalTo: hitsRequiredView.centerYAnchor).isActive = true
        hitsRequiredLabel.leadingAnchor.constraint(equalTo: hitsRequiredView.leadingAnchor, constant: 30).isActive = true
        hitsRequiredIndicator.translatesAutoresizingMaskIntoConstraints = false
        hitsRequiredIndicator.dataSource = self
        hitsRequiredIndicator.delegate = self
        hitsRequiredView.addSubview(hitsRequiredIndicator)
        hitsRequiredIndicator.centerYAnchor.constraint(equalTo: hitsRequiredView.centerYAnchor).isActive = true
        hitsRequiredIndicator.trailingAnchor.constraint(equalTo: hitsRequiredView.trailingAnchor, constant: -30).isActive = true
        hitsRequiredIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        maxTimeView.translatesAutoresizingMaskIntoConstraints = false
        maxTimeView.backgroundColor = .white
        stackView.addArrangedSubview(maxTimeView)
        maxTimeView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        maxTimeView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        maxTimeView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        maxTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTimeLabel.text = "Maximum Time allowed:"
        maxTimeLabel.textColor = .black
        maxTimeView.addSubview(maxTimeLabel)
        maxTimeLabel.centerYAnchor.constraint(equalTo: maxTimeView.centerYAnchor).isActive = true
        maxTimeLabel.leadingAnchor.constraint(equalTo: maxTimeView.leadingAnchor, constant: 30).isActive = true
        maxTimeIndicator.translatesAutoresizingMaskIntoConstraints = false
        maxTimeIndicator.dataSource = self
        maxTimeIndicator.delegate = self
        maxTimeView.addSubview(maxTimeIndicator)
        maxTimeIndicator.centerYAnchor.constraint(equalTo: maxTimeView.centerYAnchor).isActive = true
        maxTimeIndicator.trailingAnchor.constraint(equalTo: maxTimeView.trailingAnchor, constant: -30).isActive = true
        maxTimeIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        targetMovementView.translatesAutoresizingMaskIntoConstraints = false
        targetMovementView.backgroundColor = .lightGray
        stackView.addArrangedSubview(targetMovementView)
        targetMovementView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        targetMovementView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        targetMovementView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        targetMovementLabel.translatesAutoresizingMaskIntoConstraints = false
        targetMovementView.addSubview(targetMovementLabel)
        targetMovementLabel.text = "Target Movement Difficulty:"
        targetMovementLabel.textColor = .black
        targetMovementLabel.centerXAnchor.constraint(equalTo: targetMovementView.centerXAnchor).isActive = true
        targetMovementLabel.topAnchor.constraint(equalTo: targetMovementView.topAnchor, constant: 10).isActive = true
        targetMovementSelector.translatesAutoresizingMaskIntoConstraints = false
        targetMovementView.addSubview(targetMovementSelector)
        targetMovementSelector.selectedSegmentIndex = 0
        targetMovementSelector.addTarget(self, action: #selector(targetMovementSelected(_:)), for: .valueChanged)
        targetMovementSelector.bottomAnchor.constraint(equalTo: targetMovementView.bottomAnchor, constant: -10).isActive = true
        targetMovementSelector.centerXAnchor.constraint(equalTo: targetMovementView.centerXAnchor, constant: 0).isActive = true
        
        // Save,Cancel Buttons Setup
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveButton)
        saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        cancelButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
    }
    
    func setupViewWithValues() {
        showMaxHitsRequired()
    }
    
    @objc func saveButtonPressed(_ sender:UIButton) {
        gameConfigurationViewDelegate?.saveButtonPressed()
    }
    
    @objc func cancelButtonPressed(_ sender:UIButton) {
        gameConfigurationViewDelegate?.cancelButtonPressed()
    }
    
    @objc func challengeTypeSelected(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            showMaxHitsRequired()
        case 1:
            showMaxTimeAllowed()
        default:
            showMaxHitsRequired()
        }
    }
    
    func showMaxHitsRequired() {
        UIView.animate(withDuration: 0.3) {
            self.stackView.arrangedSubviews[3].isHidden = true
        } completion: { success in
            UIView.animate(withDuration: 0.3) {
                self.stackView.arrangedSubviews[2].isHidden = false
            }
        }
    }
    
    func showMaxTimeAllowed() {
        UIView.animate(withDuration: 0.3) {
            self.stackView.arrangedSubviews[2].isHidden = true
        } completion: { success in
            UIView.animate(withDuration: 0.3) {
                self.stackView.arrangedSubviews[3].isHidden = false
            }
        }
    }
    
    @objc func targetMovementSelected(_ segmentedControl: UISegmentedControl) {
    }
    
}

extension GameConfigurationView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.hitsRequiredIndicator {
            return hitsRequiredRange.count
        } else if pickerView == self.maxTimeIndicator {
            return maxTimeRangeInSeconds.count
        } else {
            return 0
        }
    }
}

extension GameConfigurationView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.hitsRequiredIndicator {
            let number = hitsRequiredRange[row]
            return String(number)
        } else if pickerView == self.maxTimeIndicator {
            let number = maxTimeRangeInSeconds[row]
            return String(number)
        } else {
            return "0"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Do stuff per Picker
    }
}


//
//  ViewController.swift
//  RxSampleTextField
//
//  Created by Motohiro Tajima on 2019/08/08.
//  Copyright © 2019 Motohiro Tajima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var inputUserIDTextField:UITextField!
    @IBOutlet weak var mistakUserIDLabel: UILabel!
    @IBOutlet weak var characterCountUserIDLabel: UILabel!
    @IBOutlet weak var inputPasswordTextField:UITextField!
    @IBOutlet weak var mistakPasswordLabel: UILabel!
    @IBOutlet weak var characterCountPasswordLabel: UILabel!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    private let maxLength: Int = 10
    private let minimumTextLength: Int = 6
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        inputUserIDTextField.rx.text.subscribe(onNext: { text in
            if let text = text,text.count >= self.maxLength{
                self.inputUserIDTextField.text = text.prefix(self.maxLength).description
                print(text)
            }
            let inputTextLength = self.inputUserIDTextField.text?.count ?? 0
            let remainCount = self.maxLength - inputTextLength
            self.characterCountUserIDLabel.text = "残り\(remainCount)文字"
            self.signUpButton.isEnabled = (inputTextLength > 0)
            guard let isMistakUserIDLabel = text?.isAlphanumeric() else { return }
            if inputTextLength != 0{
                self.mistakUserIDLabel.isHidden = isMistakUserIDLabel
            } else {
                self.mistakUserIDLabel.isHidden = true
            }
            
        }).disposed(by: disposeBag)
        
        
        inputPasswordTextField.rx.text.subscribe(onNext: { text in
            let inputTextLength = self.inputPasswordTextField.text?.count ?? 0
            guard let isMistakPassworrdLabal = text?.isCharacterString(text:text!) else { return }
            self.mistakPasswordLabel.isHidden = !isMistakPassworrdLabal
            self.signUpButton.isEnabled = (inputTextLength <= self.minimumTextLength)
            
        })
        
        signUpButton.rx.tap.subscribe(onNext:{
            let storyboard = UIStoryboard(name: "SecondViewController", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "second")
            self.navigationController?.pushViewController(nextVC, animated: true)
        }).disposed(by: disposeBag)
        
    }


}

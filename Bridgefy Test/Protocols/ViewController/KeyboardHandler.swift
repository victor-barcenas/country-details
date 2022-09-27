//
//  KeyboardHandler.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

protocol KeyboardHandler: AnyObject {
    
    var scrollView: UIScrollView! { get set }
    var contentView: UIView! { get set }
    var activeField: UITextField? { get set }
    var keyboardHeight: CGFloat! { get set }
    var lastOffset: CGPoint! { get set }
    
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func startObservingKeyboardChanges()
    func stopObservingKeyboardChanges()
}


extension KeyboardHandler where Self: KeyboardController {

    func startObservingKeyboardChanges() {
        let notificationCenter = NotificationCenter.default
        
        // NotificationCenter observers
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        // Deal with rotations
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(_:)),
                                       name: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil)
        // Deal with keyboard change (emoji, numerical, etc.)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(_:)),
                                       name: UITextInputMode.currentInputModeDidChangeNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        keyboardHeight = 0
    }
    
    func stopObservingKeyboardChanges() {
        view.endEditing(true)
        NotificationCenter.default.removeObserver(self)
    }
}

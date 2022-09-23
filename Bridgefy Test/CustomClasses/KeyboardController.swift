//
//  KeyboardController.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import UIKit

class KeyboardController: UIViewController, KeyboardHandler {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    var charCount: Int = 0
    lazy var fields: [UITextField] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(returnTextView(gesture:))))
        startObservingKeyboardChanges()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard scrollView != nil else { return }
        //The designs are based on iPhone 13 mini that's why we campare against 812
        guard view.frame.height < 812 else {
            scrollView.isScrollEnabled = false
            return
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: 812)
        if let heightConstraint = scrollView.constraints.first(where: { $0.firstAttribute == .height }) {
            if let centerYConstraint = scrollView.constraints.first(where: { $0.firstAttribute == .centerY }) {
                scrollView.removeConstraint(centerYConstraint)
            }
            heightConstraint.constant = 812
        }
        scrollView.isScrollEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        view.endEditing(true)
       stopObservingKeyboardChanges()
    }
    
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
    func set(delegate: UITextFieldDelegate, for fields: [UITextField]) {
        fields.forEach({
            $0.delegate = delegate
        })
    }
}

extension KeyboardController {
    @objc func keyboardWillShow(_ notification: Notification) {
        guard keyboardHeight >= 0 else { return }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // move if keyboard hide input field
            let scrollHeigth = scrollView.frame.size.height
            let fieldYPos = activeField?.frame.origin.y ?? 0.0
            var fieldHeight: CGFloat!
            fieldHeight = activeField?.frame.size.height ?? 0.0
            let distanceToBottom = scrollHeigth - fieldYPos - fieldHeight
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                // scroll to the position above keyboard 10 points
                if self?.lastOffset == nil {
                    self?.lastOffset = .zero
                }
                self?.scrollView.contentOffset = CGPoint(x: self?.lastOffset.x ?? 0.0, y: collapseSpace)
            })
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            // scroll to the position above keyboard 10 points
            self?.scrollView.contentOffset = self?.lastOffset ?? .zero
        })
        keyboardHeight = 0
    }
}

extension KeyboardController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField =  textField
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeField = nil
        scrollView.setContentOffset(.zero, animated: true)
        return true
    }
}

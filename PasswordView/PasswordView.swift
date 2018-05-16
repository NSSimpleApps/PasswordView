//
//  PasswordView.swift
//  PasswordView
//
//  Created by NSSimpleApps on 04.12.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

extension CGRect {
    init(center: CGPoint, size: CGFloat) {
        self.init(x: center.x - size/2, y: center.y - size/2, width: size, height: size)
    }
}

protocol PasswordViewDelegate: NSObjectProtocol {
    func enterPasswordDidFinish(_ passwordView: PasswordView)
}

public class PasswordView: UIView, UIKeyInput, UITextInputTraits {
    public let passwordLength: Int
    
    weak var delegate: PasswordViewDelegate?
    
    public fileprivate(set) var text: String = ""
    
    static let blueColor = UIColor(red: 42.0/255, green: 114.0/255, blue: 208.0/255, alpha: 1)
    static let redColor = UIColor(red: 231.0/255, green: 76.0/255, blue: 60.0/255, alpha: 1)
    static let greenColor = UIColor(red: 46.0/255, green: 204.0/255, blue: 113.0/255, alpha: 1)
    
    public init(frame: CGRect, passwordLength: Int) {
        self.passwordLength = passwordLength
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.tintColor = PasswordView.blueColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func removeText() {
        if self.text.isEmpty == false {
            self.text.removeAll()
            self.setNeedsDisplay()
        }
    }
    
    private func shake(numberOfTimes times: Int, delta: CGFloat, completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.05, animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: CGFloat(times) * delta, y: 0)
            
        }, completion: { (finished: Bool) -> Void in
            if times <= 0 {
                UIView.animate(withDuration: 0.05, animations: { () -> Void in
                    self.transform = .identity
                },
                               completion: { (finished: Bool) in
                                if finished {
                                    completion()
                                }
                })
            } else {
                self.shake(numberOfTimes: times - 1, delta: -delta, completion: completion)
            }
        })
    }
    
    public func shake(completion: @escaping () -> ()) {
        self.shake(numberOfTimes: 5, delta: 10, completion: completion)
    }
    
    public var hasText: Bool {
        return self.text.isEmpty == false
    }
    
    public func insertText(_ text: String) {
        if self.text.count < self.passwordLength {
            self.text.append(text)
            self.setNeedsDisplay()
            
            if self.text.count == self.passwordLength {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { () -> Void in
                    self.delegate?.enterPasswordDidFinish(self)
                })
            }
        }
    }
    
    public func deleteBackward() {
        if self.text.isEmpty == false {
            self.text.removeLast()
            self.setNeedsDisplay()
        }
    }
    
    override public var canBecomeFirstResponder : Bool {
        return true
    }
    
    public var autocorrectionType: UITextAutocorrectionType {
        get { return .no }
        set(new) { /* do nothing */ }
    }
    
    public var spellCheckingType: UITextSpellCheckingType {
        get { return .no }
        set(new) { /* do nothing */ }
    }
    
    public var keyboardType: UIKeyboardType {
        get { return .numberPad }
        set(new) { /* do nothing */ }
    }
    
    public override var tintColor: UIColor! {
        get { return super.tintColor }
        set(new) {
            super.tintColor = new
            self.setNeedsDisplay()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let d: CGFloat = 11
        let D: CGFloat = 21
        let space = (rect.width - CGFloat(self.passwordLength) * D) / CGFloat(self.passwordLength - 1)
        let count = self.text.count
        
        context?.setFillColor(self.tintColor.cgColor)
        
        for i in (0 ..< count) {
            context?.addEllipse(in: CGRect(center: CGPoint(x: D/2 + CGFloat(i)*(D + space), y: rect.midY), size: D))
        }
        context?.fillPath()
        context?.setStrokeColor(self.tintColor.cgColor)
        context?.setLineWidth(2)
        
        for i in (count ..< self.passwordLength) {
            context?.addEllipse(in: CGRect(center: CGPoint(x: D/2 + CGFloat(i)*(D + space), y: rect.midY), size: d))
        }
        context?.strokePath()
    }
}

//
//  STComboBox.swift
//  STComboBox
//
//  Created by Saulo Tauil on 03/11/15.
//  Copyright © 2015 Saulo Tauil. All rights reserved.
//

import UIKit

@IBDesignable public class STComboBox: UITextField, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    public var data: [String]? {
        didSet {
            
        }
    }
    public var itemSelected : ((index: Int, text: String) -> Void)?
    
    var pickerView: UIPickerView = {
        let ret = UIPickerView();
        ret.showsSelectionIndicator = true
        
        
        
        return ret;
    }()
    
    var toolBar: UIToolbar?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    weak var pickerDelegate: UIPickerViewDelegate?;
    weak var pickerSource: UIPickerViewDataSource?;
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        self.initialize();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize();
    }
    
    private func initialize(){
        
        let pickerToolbar = UIToolbar()
        //ret.barStyle = toolBarStyle
        pickerToolbar.sizeToFit()
        
        let done = UIBarButtonItem(title: "Select", style: UIBarButtonItemStyle.done, target: self, action: #selector(STComboBox.doneClicked(btn:)));
        
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(STComboBox.cancelClicked(btn:)));
        
        toolBar = pickerToolbar;
        
        toolBar?.setItems([cancel, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil), done], animated: true);
        
        
        pickerView.delegate = self;
        pickerView.dataSource = self;
        self.delegate = self;
        
        self.inputView = pickerView;
        self.inputAccessoryView = toolBar
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data?[row] ?? "<Empty>"
    }
    
    //MARK: - TextFieldDelegate
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if data?.count ?? 0 > 0 {
            showPicker(textField: textField);
            return true
        }
        return false
    }
    

    
    //MARK: - picker controller
    func showPicker(textField: UITextField){
        
    }
    
    //MARK: - button selectors
    
    func doneClicked(btn: AnyObject?){
        
        let idx = pickerView.selectedRow(inComponent: 0);
        
        let txt = data![idx];
        self.text = txt
        
        itemSelected?(index: idx, text: txt)
        
        resignFirstResponder()
        
        
    }
    func cancelClicked(btn: AnyObject?){
        resignFirstResponder()
        
    }
    
    //MARK: - disable paste and select
    
    public override func canPerformAction(_ action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(UITextField.paste(_:)) ||
            action == #selector(UITextField.select(_:)) ||
            action == #selector(UITextField.cut(_:))  ||
            action == #selector(UITextField.selectAll(_:))  ||
            action == #selector(UITextField.delete(_:)) {
            return false;
        }
        return true;
    }
    
    
}

//
//  ViewController.swift
//  Programming Assistant
//
//  Created by spectator Mr.Z on 2018/9/28.
//  Copyright © 2018 Mr.Z. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var nameV: NSTextField!
    
    @IBOutlet var inputView: NSTextView!
    
    @IBOutlet var outputV: NSTextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func generator(_ sender: Any) {
        
        var str = outputV.string
        let name = nameV.stringValue
        
//        str = str.replacingOccurrences(of: "\n", with: "")
//        str = str.replacingOccurrences(of: "\t", with: "")
//        str = str.replacingOccurrences(of: "\"", with: "\"")
        let json = JSON.init(parseJSON: str)
        
        var subDic = [String: JSON]()
        var subC = 1
        
        var resultStr = "struct \(name) : SNSwiftyJSONAble { \n"
        
        var variableStr = ""
        
        var initStr = "init?(jsonData: JSON) { \n"
        
        if let dic = json.dictionary {
            
            for (key,value) in dic {
                if let val = value.string {
                variableStr += "let \(key): String \n"
                initStr += "self.\(key) = jsonData[\"\(key)\"].stringValue \n"
                } else if let val = value.int {
                    variableStr += "let \(key): Int \n"
                    initStr += "self.\(key) = jsonData[\"\(key)\"].intValue \n"
                } else if let val = value.array {
                    
                } else if let val = value.dictionary {
                    
                    var resultStr1 = "struct \(name)\(subC) : SNSwiftyJSONAble { \n"
                    subC += 1
                    var variableStr1 = ""
                    var initStr1 = "init?(jsonData: JSON) { \n"
                    
                    for (key1,val1) in val {
                        if let _ = val1.string {
                            variableStr1 += "let \(key1): String \n"
                            initStr1 += "self.\(key1) = jsonData[\"\(key1)\"].stringValue"
                        }
                    }
                    
                    resultStr1 += variableStr1 + initStr1 + "} \n } \n"
                    
                    print("str1 -- "+resultStr1)
                }
                
//                else {
//
//
//                    subDic[key] = value
//                }
            }
            resultStr += variableStr + initStr + "} \n } \n"
        }
        
        print("str -- "+resultStr)
        
        inputView.string = resultStr
    }
    
}


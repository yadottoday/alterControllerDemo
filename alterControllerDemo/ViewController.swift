//
//  ViewController.swift
//  alterControllerDemo
//
//  Created by 王庆华 on 15/12/15.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    // MARK: - 属性
    let cellIdentified = "cellID"
    var numbers = ["😊","🐶","🐱","🐴","🐅","🐘","🐔","🐭","🐻","🌽"]
    
    // MARK: - 声明周期
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    
        prepareUI()
    }
    
    // MARK: - 准备UI
    func prepareUI() {
        
        // 准备UI  
    
        
        view.addSubview(tableView)
        // 注册 
        tableView.registerNib(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentified)
        
    }
    
    // MARK: - 懒加载 
    lazy var tableView: UITableView = {
        
       let tableView = UITableView()
       tableView.frame = UIScreen.mainScreen().bounds
//        tableView.editing = true
        
       // 代理 
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentified, forIndexPath: indexPath) as! MyTableViewCell
        
        cell.myLable.text = numbers[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numbers.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            numbers.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            print(1)
            alter()
        } else if indexPath.row == 1 {
            print(2)
            fromBottomAlert()
        } else if indexPath.row == 2 {
            print(3)
            imputTextField()
        }
    }
    
}


// MARK: - 提示框 
extension ViewController: UIActionSheetDelegate {
    
    func alter() {
        
        let alertController = UIAlertController(title: "系统提示", message: "您确定要离开吗", preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
        
            print("取消")
        }
        
        let oKAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            print("好的")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(oKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func fromBottomAlert() {
        
        let alterController = UIAlertController(title: "保存或删除数据", message: "删除数据将不可恢复", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "删除", style: UIAlertActionStyle.Destructive, handler: nil)
        
        let archiveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default, handler: nil)
        
        alterController.addAction(cancelAction)
        alterController.addAction(deleteAction)
        alterController.addAction(archiveAction)
        
        self.presentViewController(alterController, animated: true, completion: nil)
    }
    
    func imputTextField() {
        
        let alertController = UIAlertController(title: "系统登录", message: "请输入用户名和密码", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (
            
            textField:UITextField) -> Void in
            textField.placeholder = "用户名"
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            
            textField.placeholder = "密码"
            textField.secureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in
            let login = alertController.textFields!.first! as UITextField
            
            let password = (alertController.textFields?.last)! as UITextField
            
            print("用户名：\(login.text) 密码：\(password.text)")
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
}
}





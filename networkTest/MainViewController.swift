//
//  ViewController.swift
//  networkTest
//
//  Created by oky on 2015/01/17.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController{

    struct searchAlertController {
        static let title = "検索"
        static let message = "タイトルを入力してください"
        static let positive = "OK"
        static let negative = "Cancel"
    }
    

    @IBOutlet weak var serchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        let mainView = MainView(frame: self.view.bounds, viewController:self)
        self.view = mainView
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let book = sender as Book
        
        println(book.title)
        
        let detailViewController = segue.destinationViewController as DetailViewController
        detailViewController.setBook(book)
    }
    
    
    //http://qiita.com/takabosoft/items/adef75dfa421837e996c
    
    func dispatch_async_main(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    func dispatch_async_global(block: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    }
    
    
    func apiRequest(searchString:String){
     
        let books = Books.sharedInstance
        
        SVProgressHUD.show()
        
        dispatch_async_global({ () -> () in
            
            books.apiRequest(searchString)
            
            self.dispatch_async_main({ () -> () in
                SVProgressHUD.dismiss()
            })
            
        })
        
    }
    
    @IBAction func searchItem(sender: AnyObject) {
        
        var inputTextField:UITextField?
        
        let alert:UIAlertController = UIAlertController(title:searchAlertController.title,
            message:searchAlertController.message,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title:searchAlertController.negative,
            style: UIAlertActionStyle.Cancel,
            handler:nil)
        
        let defaultAction:UIAlertAction = UIAlertAction(title:searchAlertController.positive,
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                
                if let searchString = inputTextField!.text{
                    if countElements(searchString) >= 1 {
                    self.apiRequest(searchString)
                    }
                }
        })
        

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        alert.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            inputTextField = text
        })

        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  DetailViewController.swift
//  networkTest
//
//  Created by oky on 2015/01/18.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: M6UniversalParallaxViewController,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate{

    @IBOutlet weak var tableView: M6HeaderInsetTableView!
    @IBOutlet weak var imageView: UIImageView!
    
    struct Cell {
        static let DetailViewCellReuseIdentifier = "DetailViewCell"
    }
    
    var book:Book?
    
    func setBook(book:Book){
        self.book = book
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName:Cell.DetailViewCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: Cell.DetailViewCellReuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        let actionSheetButton = UIBarButtonItem(barButtonSystemItem:.Action, target: self, action: "showActionSheet")
        self.navigationItem.rightBarButtonItem = actionSheetButton
        

        imageView.image = book?.image
    }
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Table View
    
    let sectionTitlearray = ["タイトル","著者","価格","説明","出版社","出版日"]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitlearray.count
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitlearray[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier(Cell.DetailViewCellReuseIdentifier, forIndexPath: indexPath) as DetailViewCell
        cell.detailViewCellText.text = book?[indexPath.section]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
     // MARK: - ActionSheet
    
    
    struct actionSheetTitles {
        static let TITLE = "検索"
        static let CANCEL = "Cancel"
        static let RAKUTEN = "楽天"
        static let GOOGLE = "google"
    }
    
    func showActionSheet(){
        
        var sheet: UIActionSheet = UIActionSheet()
        sheet.title  = actionSheetTitles.TITLE
        sheet.delegate = self
        sheet.addButtonWithTitle(actionSheetTitles.CANCEL)
        sheet.addButtonWithTitle(actionSheetTitles.RAKUTEN)
        sheet.addButtonWithTitle(actionSheetTitles.GOOGLE)
        
        sheet.cancelButtonIndex = 0
        
        sheet.showInView(self.view)

    }
    
    enum actionSheets:Int{
        case RAKUTEN = 1,GOOGLE,AMAZON
    }
    
    func actionSheet(sheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        println("index %d %@", buttonIndex, sheet.buttonTitleAtIndex(buttonIndex))
        
        if buttonIndex != 0 {
            
        let url:String = {
            
            switch buttonIndex {
            case actionSheets.RAKUTEN.rawValue:
                return self.book!.itemUrl!
            case actionSheets.GOOGLE.rawValue:
                                //できない
                return "http://www.google.co.jp/search?hl=ja&source=hp&q=\(self.book!.title!)"
            default:
               return ""
            }
            
        }()
        
        showWebViewController(url)
            
        }
        
    }

    func showWebViewController(url:String){
        
        let webViewController = SVWebViewController(address: url)
        self.navigationController?.pushViewController(webViewController, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

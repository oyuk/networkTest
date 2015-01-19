//
//  MainView.swift
//  networkTest
//
//  Created by oky on 2015/01/18.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit
import Alamofire

class MainView: UIView,BooksDelegate,UITableViewDelegate{
    
    var tableView:UITableView?
    var mainViewController:MainViewController?
    let books = Books.sharedInstance
    
    init(frame: CGRect,viewController:MainViewController) {
       super.init(frame: frame)
        
        mainViewController = viewController
        tableView = UITableView(frame: frame)
        tableView?.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: Cell.reuseIdentifier)
        self.addSubview(tableView!)
        
        setModel()
    }
    
    func setModel(){
     
        books.booksDelegate = self
        tableView?.dataSource = books
        tableView?.delegate = self

    }
    
    func reloadTableViewData() {
        tableView?.reloadData()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      // MARK: - Table View
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Cell.height
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: false)
        
        let book = books.getAllbooks()[indexPath.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath)? as CustomCell
        book.image = cell.bookImageView.image
        
        
        let detailViewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailViewController.setBook(book)
        mainViewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

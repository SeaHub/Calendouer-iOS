//
//  DebugInViewViewController.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/19.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class DebugInViewViewController: UIViewController {
    
    let cellData: [DebugIn] = [
        DebugIn(id: "CalViewController"),
        DebugIn(id: "AnimationTestViewController"),
        DebugIn(id: "WeatherDetailViewController"),
        DebugIn(id: "AboutAppViewController"),
    ]
    
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        addSubView()
        configTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initialView() {
        self.title = "Debug In"
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
    
    private func addSubView() {
        view.addSubview(tableView)
    }
    
    private func configTableViewData() {
        
    }
}

extension DebugInViewViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testVC = cellData[indexPath.row].getViewController()
        self.navigationController?.pushViewController(testVC, animated: true)
    }
}

extension DebugInViewViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.text = cellData[indexPath.row].identifier
        return cell
    }
}

class DebugIn: NSObject {
    public var identifier: String = ""
    public var objClassName: String = ""
    
    init(id: String) {
        self.identifier = id
        self.objClassName = id
    }
    
    public func getViewController() -> UIViewController {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let controllerClass: AnyClass = NSClassFromString("\(nameSpace).\(self.objClassName)")!
        let realClass = controllerClass as! UIViewController.Type
        let retController = realClass.init()
        return retController as UIViewController
    }
}


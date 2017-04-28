//
//  AboutAppViewController.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/4/26.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "LithosPro-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            NSForegroundColorAttributeName: UIColor.white,
        ]
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initialViews() {
        view.backgroundColor = DouBackGray
        
        title = "CALENDOUER"
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor = DouBackGray
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        tableView.register(UINib(nibName: LogoTableViewCellId, bundle: nil), forCellReuseIdentifier: LogoTableViewCellId)
        tableView.register(UINib(nibName: AboutTextTableViewCellId, bundle: nil), forCellReuseIdentifier: AboutTextTableViewCellId)
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
}

extension AboutAppViewController: UITableViewDelegate {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension AboutAppViewController: UITableViewDataSource {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: LogoTableViewCell = tableView.dequeueReusableCell(withIdentifier: LogoTableViewCellId, for: indexPath) as! LogoTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            let cell: AboutTextTableViewCell = tableView.dequeueReusableCell(withIdentifier: AboutTextTableViewCellId, for: indexPath) as! AboutTextTableViewCell
            cell.selectionStyle = .none
            cell.setToSupport {
                self.navigationController?.pushViewController(AboutSupportViewController(), animated: true)
            }
            cell.setToOpenSource {
                self.navigationController?.pushViewController(AboutOpenSourceViewController(), animated: true)
            }
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

//
//  MovieDetailViewController.swift
//  Calendouer
//
//  Created by 段昊宇 on 2017/3/24.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var tableView: UITableView!
    var bakView: UIView!
    
    // 电影实例
    var movie: MovieObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        addSubView()
        settingLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initialView() {
        self.title = "\u{1F3AC} 电影"
        self.view.backgroundColor = DouBackGray
        
        let barbak = UIImage(color: DouGreen)
        self.navigationController?.navigationBar.setBackgroundImage(barbak, for: .default)
        
        bakView = UIView(frame: CGRect.zero)
        bakView.backgroundColor = DouGreen
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        // Table View Register
        tableView.register(UINib(nibName: MoviePostTableViewCellId, bundle: nil), forCellReuseIdentifier: MoviePostTableViewCellId)
        tableView.register(UINib(nibName: MovieIntroductionTableViewCellId, bundle: nil), forCellReuseIdentifier: MovieIntroductionTableViewCellId)
        tableView.register(UINib(nibName: MovieSummaryTableViewCellId, bundle: nil), forCellReuseIdentifier: MovieSummaryTableViewCellId)
    }
    
    private func addSubView() {
        view.addSubview(bakView)
        view.addSubview(tableView)
    }
    
    private func settingLayout() {
        bakView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.centerY)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviePostTableViewCellId, for: indexPath) as! MoviePostTableViewCell
            cell.selectionStyle = .none
            cell.movie = self.movie
            cell.setAblumClickAction(callBack: { (image) in
                let agrume = Agrume(image: image, backgroundColor: .black)
                agrume.hideStatusBar = true
                agrume.showFrom(self)
            })
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieIntroductionTableViewCellId, for: indexPath) as! MovieIntroductionTableViewCell
            cell.selectionStyle = .none
            cell.movie = self.movie
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieSummaryTableViewCellId, for: indexPath) as! MovieSummaryTableViewCell
            cell.selectionStyle = .none
            cell.movie = self.movie
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.backgroundColor = DouBackGray
            return cell
        }
    }
}

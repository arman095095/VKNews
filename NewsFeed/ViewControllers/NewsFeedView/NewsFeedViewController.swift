//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright (c) 2020 Arman Davidoff. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?

  // MARK: Object lifecycle
    var tableView: UITableView!
    var titleTopView = TitleView()
    var footerView = FooterView()
    var footerControl: Footer!
    var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshing), for: .valueChanged)
        return refresh
    }()
    var newsFeeds = NewsFeedsViewModel(cellModels: [])
    
  // MARK: Setup
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }

  // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setup()
        setupTableView()
        setupTopBar()
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUserInfo)
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(let newsFeed):
            self.newsFeeds.updateCellModels(models: newsFeed)
            updateUI()
        case .displayUserInfo(let userInfo):
            updateUIUserInfo(model: userInfo)
        case .displayNewsFeedFulltext(let newsFeed,let index):
            newsFeeds.setCellModel(at: index, cellModel: newsFeed)
            updateUIWithFullText()
        case .displayNextNewsFeed(let newsFeed):
            self.newsFeeds.addNewModels(models: newsFeed)
            updateUINext()
        case .displayErrorNewsFeed(error: _):
            updateUIError()
        case .displayErrorNextNewsFeed(error: let error):
            updateUIErrorNext(error: error)
        }
    }
    
    @objc private func refreshing() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isAtBottom && newsFeeds.mayRequestNext()  {
            footerControl.start(count: newsFeeds.numberOfCells())
            newsFeeds.disallowRequestNext()
            interactor?.makeRequest(request: .getNextNewsFeed)
        }
    }
}

// MARK: TableViewDelegate&TableViewDataSource methods
extension NewsFeedViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        footerControl.stop(count: newsFeeds.numberOfCells(),info: "")
        return newsFeeds.numberOfCells()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.cellID, for: indexPath) as! NewsFeedTableViewCell
        let model = newsFeeds.modelForCell(at: indexPath)
        cell.config(model: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsFeeds.heightForRow(at: indexPath)
    }
}

//Cell Delegate Functions
extension NewsFeedViewController: CustomCellDelegate {
    func showFullText(cell: NewsFeedTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        print(indexPath)
        self.interactor?.makeRequest(request: .showFullText(index: indexPath.row))
    }
}

//Setup UI
private extension NewsFeedViewController {
    
    func setupTopBar() {
        guard let navigationController = navigationController else { return }
        let navigationBar = navigationController.navigationBar
        navigationController.hidesBarsOnSwipe = true
        navigationController.overrideUserInterfaceStyle = .light
        navigationBar.shadowImage = UIImage()
        navigationItem.titleView = titleTopView
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        self.view.addSubview(tableView)
        tableView.contentInset.top = Constants.cardViewTopInset
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView()
        tableView.backgroundView!.addGradientInView(cornerRadius: 0)
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: NewsFeedTableViewCell.cellID)
        tableView.addSubview(refreshControl)
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.isHidden = false
        footerControl = (tableView.tableFooterView as! Footer)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
}

//Update UI
private extension NewsFeedViewController {
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.newsFeeds.allowRequestNext()
        }
    }
    
    func updateUINext() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.footerControl.stop(count:self.newsFeeds.numberOfCells(),info: "")
            self.newsFeeds.allowRequestNext()
        }
    }
    
    func updateUIErrorNext(error: NewsFeedService.Errors) {
        DispatchQueue.main.async {
            self.newsFeeds.allowRequestNext()
            self.footerControl.stop(count:self.newsFeeds.numberOfCells(),info: error.localizedDescription)
        }
    }
    
    func updateUIError() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    func updateUIWithFullText() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateUIUserInfo(model: UserInfoModel) {
        DispatchQueue.main.async {
            self.titleTopView.setup(with: model)
        }
    }
}

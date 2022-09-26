//
//  CountriesView.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 24/09/22.
//

import UIKit

class CountriesView: UIViewController, ActivityIndicatable {
    
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var viewModel: CountriesViewModel!
    
    init(_ viewModel: CountriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startLoading(with: "Getting country list...")
        viewModel.getCountries { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let countries):
                self?.viewModel.set(countries: countries)
                self?.configureTableView()
                self?.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = tableView.centerXAnchor
            .constraint(equalTo: view.centerXAnchor)
        let widthConstraint = tableView.widthAnchor
            .constraint(equalTo: view.widthAnchor)
        let topConstraint = tableView.topAnchor
            .constraint(equalTo: view.topAnchor)
        let bottomConstraint = tableView.bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
        let heightConstraint = tableView.heightAnchor
            .constraint(equalTo: view.heightAnchor)
        
        view.addConstraints([
            widthConstraint,
            centerXConstraint,
            topConstraint,
            bottomConstraint,
            heightConstraint
        ])
        tableView.register(CountryCell.self,
                           forCellReuseIdentifier: CountryCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.layoutIfNeeded()
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }
    
    @objc func groupAction(_ sender: Any) {
        viewModel.group()
        if viewModel.areCountriesGrouped {
            searchBar.removeFromSuperview()
            tableView.tableHeaderView = nil
            setRightBarButton("Ungroup", selector: #selector(groupAction(_:)))
        } else {
            configureSearchBar()
            setRightBarButton("Group", selector: #selector(groupAction(_:)))
        }
        reloadTableView()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CountriesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText)
        reloadTableView()
    }
}

extension CountriesView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionsCount
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countryCell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier,
                                                              for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        guard let country = viewModel.country(at: indexPath) else {
            return UITableViewCell()
        }
        countryCell.configure(with: country)
        return countryCell
    }
}

extension CountriesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0,
                           width: tableView.frame.width,
                           height: 35)
        let header = UIView(frame: frame)
        let title = UILabel(frame: CGRect(x: 16, y: 0,
                                          width: tableView.frame.width,
                                          height: 35))
        title.text = viewModel.titleFor(section)
        title.font = UIFont.boldSystemFont(ofSize: 21)
        header.addSubview(title)
        header.backgroundColor = .headerBackground
        return header
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.areCountriesGrouped else { return 0 }
        return 35
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}

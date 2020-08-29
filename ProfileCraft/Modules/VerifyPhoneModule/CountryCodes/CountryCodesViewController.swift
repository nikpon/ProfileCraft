import UIKit

final class CountryCodesViewController: UIViewController {
    
    // MARK: - Properties
    private var countryCodesView: CountryCodesView {
        return view as! CountryCodesView
    }
    
    var coordinator: CountryCodesCoordinator?
    
    let searchController = UISearchController(searchResultsController: nil)
    var countryCodes = [[String]]()
    var filteredCountryCodes = [[String]]()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func loadView() {
        let countryCodesView = CountryCodesView()
        view = countryCodesView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Methods
    private func commonInit() {
        countryCodesView.tableView.dataSource = self
        countryCodesView.tableView.delegate = self
        title = "Choose your country"
        configureSearchController()
        configureNavigationBar()
        
        CountryCodeService.shared.getCountryCodes { result in
            switch result {
            case .success(let countryCodes):
                self.countryCodes = countryCodes
                self.countryCodesView.tableView.reloadData()
            case .failure(let error):
                fatalError(error.rawValue)
            }
        }
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCountryCodes = countryCodes.filter({ $0[0].lowercased().contains(searchText.lowercased()) })
        countryCodesView.tableView.reloadData()
    }
    
    // MARK: - Actions
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UISearchResultsUpdating
extension CountryCodesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchBarText)
    }
    
}

// MARK: - UITableViewDataSource
extension CountryCodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountryCodes.count
        }
        return countryCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCodesTableViewCell.identifier, for: indexPath) as! CountryCodesTableViewCell
        
        let countryCode: [String] = isFiltering ? filteredCountryCodes[indexPath.row] : countryCodes[indexPath.row]
        
        cell.countryLabel.text = countryCode[0]
        cell.countryCodeLabel.text = "+" + countryCode[1]
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CountryCodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryCode: [String] = isFiltering ? filteredCountryCodes[indexPath.row] : countryCodes[indexPath.row]
        let countryCodeString = countryCode[1]
        
        coordinator?.finish(with: countryCodeString)
        searchController.dismiss(animated: false, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
}

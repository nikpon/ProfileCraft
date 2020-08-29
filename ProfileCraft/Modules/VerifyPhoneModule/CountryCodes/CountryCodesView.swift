import UIKit

final class CountryCodesView: UIView {
    
    // MARK: - Properties
    let tableView = UITableView()
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func commonInit() {
        backgroundColor = .systemGray6
        setupViews()
        configureTableView()
    }
    
    private func setupViews() {
        addSubviews(tableView)
        
        setupTableView()
    }
    
    private func configureTableView() {
        tableView.register(CountryCodesTableViewCell.self, forCellReuseIdentifier: CountryCodesTableViewCell.identifier)
        tableView.backgroundColor = UIColor.white
        tableView.layer.isOpaque = true
        tableView.rowHeight = 50
    }
    
}

// MARK: - Setup Views
private extension CountryCodesView {
    
    func setupTableView() {
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
    }
    
}

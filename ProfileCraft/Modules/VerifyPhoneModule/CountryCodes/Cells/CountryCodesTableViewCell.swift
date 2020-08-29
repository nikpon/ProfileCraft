import UIKit

final class CountryCodesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let countryLabel = PCLabel(text: nil, font: .systemFont(ofSize: 17), textColor: .black, textAlignment: .left)
    
    let countryCodeLabel = PCLabel(text: nil, font: .systemFont(ofSize: 14), textColor: .gray, textAlignment: .right)
    
    static let identifier = String(describing: CountryCodesTableViewCell.self)

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func commonInit() {
        layer.isOpaque = true
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubviews(countryLabel, countryCodeLabel)
        
        setupCountryLabel()
        setupCountryCodeLabel()
    }
    
}

// MARK: - Setup Views
private extension CountryCodesTableViewCell {
    
    func setupCountryLabel() {
        countryLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, paddingLeading: 10)
    }
    
    func setupCountryCodeLabel() {
        countryCodeLabel.anchor(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTrailing: 10)
    }
    
}

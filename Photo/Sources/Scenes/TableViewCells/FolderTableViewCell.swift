import UIKit

class FolderTableViewCell: UITableViewCell {

    let folderSectionNameLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 22, weight: .bold)

        return name
    }()

    private lazy var folderSectionNameStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal

        return stackView
    }()

    private lazy var foldersTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.sectionFooterHeight = 20
        
        table.dataSource = self
        table.delegate = self

        return table
    }()


    private lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .red

        return view
    }()

    var folders = [AlbumViewController.OtherFolder]()

    var foldersSection: AlbumViewController.FolderSection? {
        didSet {
            guard let foldersItem = foldersSection else { return }

            folderSectionNameLabel.text = foldersItem.name
            folders = foldersItem.folders
        }
    }

    private func setupHierarchy() {
        contentView.addSubview(folderSectionNameStackView)

        folderSectionNameStackView.addArrangedSubview(folderSectionNameLabel)
        contentView.addSubview(foldersTableView)
    }

    private func setupLayout() {
        folderSectionNameStackView.translatesAutoresizingMaskIntoConstraints = false

        folderSectionNameStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        folderSectionNameStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        folderSectionNameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        foldersTableView.translatesAutoresizingMaskIntoConstraints = false
        foldersTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        foldersTableView.topAnchor.constraint(equalTo: folderSectionNameStackView.bottomAnchor, constant: 20).isActive = true
        foldersTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        foldersTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupHierarchy()
        setupLayout()

        foldersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FolderCell")
        foldersTableView.isScrollEnabled = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension FolderTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath)

        cell.accessoryType = .disclosureIndicator

        var content = cell.defaultContentConfiguration()

        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.systemBlue, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]
        content.attributedText = NSAttributedString(string: folders[indexPath.row].name, attributes: attributedStringColor)

        let attributedSecondaryText = [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        content.secondaryAttributedText = NSAttributedString(string: String(folders[indexPath.row].count), attributes: attributedSecondaryText)
        content.prefersSideBySideTextAndSecondaryText = true

        content.imageProperties.tintColor = .systemBlue
        content.image = folders[indexPath.row].icon

        cell.contentConfiguration = content

        if indexPath.row == (folders.count - 1) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

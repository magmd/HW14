import UIKit

class AlbumTableViewCell: UITableViewCell {

    let albumSectionNameLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 22, weight: .bold)

        return name
    }()

    let albumSectionSeeAllLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 17)
        name.text = "See All"
        name.textColor = .systemBlue
        name.textAlignment = .right

        return name
    }()

    private lazy var albumSectionNameStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal

        return stackView
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true

        return collection
    }()

    var albums = [AlbumViewController.MyAlbum]()

    var albumCell: AlbumViewController.AlbumSection? {
        didSet {
            guard let albumItem = albumCell else { return }

            albumSectionNameLabel.text = albumItem.name
            albums = albumItem.albums
        }
    }

    private func setupLayout() {
        albumSectionNameStackView.translatesAutoresizingMaskIntoConstraints = false

        albumSectionNameStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        albumSectionNameStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        albumSectionNameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: albumSectionNameStackView.bottomAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    private func setupHierarchy() {
        contentView.addSubview(albumSectionNameStackView)

        albumSectionNameStackView.addArrangedSubview(albumSectionNameLabel)
        albumSectionNameStackView.addArrangedSubview(albumSectionSeeAllLabel)

        contentView.addSubview(collectionView)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupHierarchy()
        setupLayout()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "AlbumCollectionViewCell")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension AlbumTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 210)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell

        cell.albumCell = albums[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

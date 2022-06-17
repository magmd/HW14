import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5

        return imageView
    }()

    let albumName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)

        return label
    }()

    let photosCount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray

        return label
    }()

    private lazy var albumStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 5

        return stackView
    }()


    var albumCell: AlbumViewController.MyAlbum? {
        didSet {
            guard let albumItem = albumCell else { return }

            albumName.text = albumItem.name
            coverImage.image = albumItem.image
            photosCount.text = albumItem.secondaryText
        }
    }

    func setupHierarchy() {
        contentView.addSubview(albumStackView)

        albumStackView.addArrangedSubview(coverImage)
        albumStackView.addArrangedSubview(albumName)
        albumStackView.addArrangedSubview(photosCount)
        albumStackView.addArrangedSubview(UIView())

    }

    func setupLayout() {
        albumStackView.translatesAutoresizingMaskIntoConstraints = false

        albumStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        albumStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        albumStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        albumStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.heightAnchor.constraint(equalTo: albumStackView.widthAnchor).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

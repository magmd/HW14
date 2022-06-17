import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var myAlbumsData: AlbumSection = {

        let albums = [
            MyAlbum(name: "Recents", secondaryText: "3456", imageName: "image1"),
            MyAlbum(name: "WhatsApp", secondaryText: "401", imageName: "image2"),
            MyAlbum(name: "Favourites", secondaryText: "154", imageName: "image3"),
            MyAlbum(name: "Instagram", secondaryText: "45", imageName: "image4"),
            MyAlbum(name: "Telegram", secondaryText: "321", imageName: "image5"),
            MyAlbum(name: "Facebook", secondaryText: "43", imageName: "image6"),
            MyAlbum(name: "WhatsApp", secondaryText: "21", imageName: "image7"),
            MyAlbum(name: "Instagram", secondaryText: "34", imageName: "image8")
        ]

        let albumSection = AlbumSection(name: "My Albums", albums: albums)

        return albumSection
    }()

    private lazy var sharedAlbumsData: AlbumSection = {

        let albums = [
            MyAlbum(name: "Work", secondaryText: "From You", imageName: "image1"),
            MyAlbum(name: "Summer", secondaryText: "From You", imageName: "image2"),
            MyAlbum(name: "Family", secondaryText: "From You", imageName: "image3"),
            MyAlbum(name: "Cars", secondaryText: "From You", imageName: "image4")
        ]

        let albumSection = AlbumSection(name: "Shared Albums", albums: albums)

        return albumSection
    }()

    private lazy var mediaTypes: FolderSection = {
        let folders = [
            OtherFolder(name: "Videos", iconName: "video", count: 123),
            OtherFolder(name: "Selfies", iconName: "person.crop.square", count: 66),
            OtherFolder(name: "Live Photos", iconName: "livephoto", count: 14),
            OtherFolder(name: "Portrait", iconName: "cube", count: 54),
            OtherFolder(name: "Screenshots", iconName: "camera.viewfinder", count: 24),
            OtherFolder(name: "Screen Recordings", iconName: "smallcircle.filled.circle", count: 2)
        ]

        let folderSection = FolderSection(name: "Media Types", folders: folders)

        return folderSection
    }()

    private lazy var utilities: FolderSection = {
        let folders = [
            OtherFolder(name: "Imports", iconName: "square.and.arrow.down", count: 312),
            OtherFolder(name: "Hidden", iconName: "eye.slash", count: 0),
            OtherFolder(name: "Recently Deleted", iconName: "trash", count: 73)
        ]

        let folderSection = FolderSection(name: "Utilities", folders: folders)

        return folderSection
    }()

    private lazy var albumsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.sectionFooterHeight = 20

        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayout()
        setupView()
    }

    private func setupHierarchy() {
        view.addSubview(albumsTableView)
    }

    private func setupLayout() {

        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        albumsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        albumsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        albumsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        albumsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setupView() {

        navigationItem.title = "Albums"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.layoutMargins.left = 20

        navigationItem.leftBarButtonItem = .init(systemItem: .add)

        albumsTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
        albumsTableView.register(FolderTableViewCell.self, forCellReuseIdentifier: "FolderTableViewCell")
        albumsTableView.delegate = self
        albumsTableView.dataSource = self

        view.backgroundColor = .systemBackground
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 500
        case 1:
            return 280
        case 2:
            return 360
        case 3:
            return 200
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as! AlbumTableViewCell
            cell.albumCell = myAlbumsData
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as! AlbumTableViewCell
            cell.albumCell = sharedAlbumsData
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FolderTableViewCell") as! FolderTableViewCell
            cell.foldersSection = mediaTypes
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FolderTableViewCell") as! FolderTableViewCell
            cell.foldersSection = utilities
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }

}

extension AlbumViewController {

    struct MyAlbum {
        let name: String
        let secondaryText: String
        let image: UIImage

        init(name: String, secondaryText: String, imageName: String) {
            self.name = name
            self.secondaryText = secondaryText
            self.image = UIImage(named: imageName) ?? UIImage()
        }
    }

    struct AlbumSection {
        let name: String
        let albums: [MyAlbum]
    }

    struct OtherFolder {
        let name: String
        let icon: UIImage
        let count: UInt

        init(name: String, iconName: String, count: UInt) {
            self.name = name
            self.icon = UIImage(systemName: iconName) ?? UIImage()
            self.count = count
        }
    }

    struct FolderSection {
        let name: String
        let folders: [OtherFolder]
    }
}

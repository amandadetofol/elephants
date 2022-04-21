import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    private let api: ApiClientProtocol = ApiService()
    var elephants: [Elephant] = []
    
    private var loader : UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()
    
    private let bottomHomeViewControllerCardView: BottomHomeViewControllerCardView = {
        let card = BottomHomeViewControllerCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var elephantsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.bounds.width - 10, height: self.view.bounds.width)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        self.present(loader, animated: true, completion: nil)
        self.getElephants()
        super.viewDidLoad()
        buildView()
        setupNavigationTitle()
        setupConstraints()
    }
    
    //MARK: Private methods
    private func buildView(){
        self.view.addSubview(elephantsCollectionView)
        self.view.addSubview(bottomHomeViewControllerCardView)
    }
    
    private func setupNavigationTitle(){
        self.navigationItem.title = "Elephants"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .done, target: self, action: #selector(showFavoritesButton))
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            elephantsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            elephantsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            elephantsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            elephantsCollectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height - 230),
            
            bottomHomeViewControllerCardView.topAnchor.constraint(equalTo: elephantsCollectionView.bottomAnchor),
            bottomHomeViewControllerCardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomHomeViewControllerCardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomHomeViewControllerCardView.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
    
    private func getElephants() {
        self.api.getElephants(baseUrl: ApiEndpoints.baseEndpointUrl.rawValue, endpoint: .allElephants) { elephants, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.elephants = elephants!
                DispatchQueue.main.async {
                    self.loader.dismiss(animated: true, completion: nil)
                    self.elephantsCollectionView.reloadData()
                }
            }
            
        }
    }
}


extension HomeViewController {
    @objc func showFavoritesButton(){
        let favoriteViewController = FavoriteViewController()
        self.navigationController?.pushViewController(favoriteViewController, animated: true)
    }
}


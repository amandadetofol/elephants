import UIKit

class FavoriteViewController: UIViewController {
    
    private var favoriteElephants: [DBElephant] = {
        return CoreDataManager().getElephants()
    }()
    
    private lazy var favoriteElephantsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false 
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
        self.setupConstraints()
        self.favoriteElephantsTableView.reloadData()
    }
    
    //MARK: Private methods
    private func buildView(){
        self.view.addSubview(favoriteElephantsTableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            favoriteElephantsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            favoriteElephantsTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            favoriteElephantsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            favoriteElephantsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func updateTableView(){
        favoriteElephants = CoreDataManager().getElephants()
        DispatchQueue.main.async {
            self.favoriteElephantsTableView.reloadData()
        }
    }
    
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteElephants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tableCellId")
        cell.textLabel?.text = favoriteElephants[indexPath.row].name
        cell.detailTextLabel?.text = favoriteElephants[indexPath.row].eldescription
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
}

extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager().deleteDBElephant(elephant: favoriteElephants[indexPath.row])
        self.updateTableView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

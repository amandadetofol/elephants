import UIKit

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.elephants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let elephantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        configureCollectionViewCell(collectionViewCell: elephantCell, indexPath: indexPath)
        return elephantCell
    }
    
    private func configureCollectionViewCell(collectionViewCell: UICollectionViewCell, indexPath: IndexPath)  {
        guard let url = URL(string: elephants[indexPath.row].image?.replacingOccurrences(of: "https", with: "http") ?? "") else { return }
        let image = UIImageView()
        image.kf.setImage(with: url,
                          placeholder: UIImage(named: "placeholder"),
                          options: nil,
                          completionHandler: nil)
        
        collectionViewCell.backgroundView = image
        collectionViewCell.clipsToBounds = true
    }
}

import UIKit

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.elephant = elephants[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

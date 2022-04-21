
import UIKit

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    var elephant: Elephant? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        detailView.delegate = self
        detailView.name = elephant?.name ?? "Elephant"
        detailView.imageUrl = elephant?.image ?? ""
        detailView.specie = elephant?.species ?? "Asian"
        detailView.sex = elephant?.sex ?? "Male"
        detailView.eldescription = elephant?.note ?? "Ops! This elephant does not have any description."
        self.view = detailView
    }
    
}

extension DetailViewController: DetailViewDelegate {
    
    func handleFavoriteButtonTap(isFavorite: Bool) {
        guard let elephant = elephant else { return }
        if isFavorite {
            CoreDataManager().saveElephant(elephant: elephant)
        } else {
            CoreDataManager().deleteElephant(elephant: elephant)
        }
        
    }
}

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            registerCell()
            startSpinner()
        }
    }
    
    // MARK: - Variables
    let spinner = UIActivityIndicatorView(style: .large)
    let viewModel = ViewModel()
    
    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadData(onSuccess: { [weak tableView] in
            guard let tableView = tableView else { return }
            UIView.transition(with: tableView, duration: 0.4, options: .transitionCrossDissolve) {
                tableView.reloadData()
                tableView.backgroundView = nil
            }
        }, onFailure: { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
            self?.present(alert, animated: true, completion: nil)
        })
    }
    
    
    // MARK: - Methods
    private func registerCell() {
        let textFieldCell = UINib(nibName: UserTableViewCell.id, bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: UserTableViewCell.id)
    }
    
    private func startSpinner() {
        spinner.startAnimating()
        tableView.backgroundView = spinner
    }
}


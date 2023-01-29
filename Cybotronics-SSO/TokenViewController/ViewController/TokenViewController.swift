import UIKit
enum TableSection {
    case first
}
class TokenViewController: UIViewController {

    // MARK: - UI Properties
    private lazy var tableView = UITableView(frame: .zero)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureTableView()
    }



    private func configureTableView() {
        view.addSubview(tableView)
        tableView.registerCell(type: TokenTableViewCell.self)
        tableView.addConstraintsToFillView(view)

        tableView.backgroundColor = .white
        tableView.separatorColor = .lightGray

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine

    }
}
extension TokenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: TokenTableViewCell.self) as? TokenTableViewCell else { return UITableViewCell() }
        cell.startTimer()
        return cell
    }
}

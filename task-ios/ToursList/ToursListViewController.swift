//
//  ToursListViewController.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 27.11.23.
//

import UIKit
import RxSwift
import ReactorKit
import RxDataSources

class ToursListViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private let tourCellId = "tourCellId"
    
    weak var setCurrentPageDelegate: SetCurrentPageDelegate?
    weak var openDetailsScreenDelegate: OpenDetailsScreenDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ToursApp.mainBackground
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        reactor?.action.onNext(.getToursListData)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let delegate = setCurrentPageDelegate, let reactor = reactor else { return }
        if reactor.isTop5 {
            delegate.currentPage(index: 1)
        } else {
            delegate.currentPage(index: 0)
        }
    }

    init(reactor: ToursListReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.ToursApp.mainBackground
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 80
        $0.showsVerticalScrollIndicator = false
        $0.register(TourCell.self, forCellReuseIdentifier: tourCellId)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
}

extension ToursListViewController: View {
    typealias Reactor = ToursListReactor
    
    func bind(reactor: ToursListReactor) {
        let dataSource = RxTableViewSectionedAnimatedDataSource<ToursListSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .none, deleteAnimation: .left),
            configureCell: { [weak self] _ , tableView, indexPath, item in
                guard let self = self, let cell = tableView.dequeueReusableCell(withIdentifier: self.tourCellId, for: indexPath) as? TourCell else { 
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.tour = item
                return cell
            })
        
        reactor.state.map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let toursData = reactor.currentState.toursListData, let openDetailsDelegate = self?.openDetailsScreenDelegate {
                    openDetailsDelegate.openDetailsScreenFor(tour: toursData[indexPath.row])
                }
            })
            .disposed(by: disposeBag)
    }
}


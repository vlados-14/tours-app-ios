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
    
    weak var setCurrentPageDelegate: SetCurrentPageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ToursApp.mainBackground
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
}

extension ToursListViewController: View {
    typealias Reactor = ToursListReactor
    
    func bind(reactor: ToursListReactor) {
        
    }
}


//
//  SortFilterOptionsViewController.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 24.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

protocol SortFilterOptionsViewControllerDelegate: NSObjectProtocol {
    func didClickApplyFilterButton()
}

final class SortFilterOptionsViewController: UIViewController {

    weak var delegate: SortFilterOptionsViewControllerDelegate?

    var sortFilterOptions: SortFilterOptions

    lazy var sortFilterOptionsView: SortFilterOptionsView = {
        let sortFilterOptionsView = SortFilterOptionsView(sortFilterOptions: sortFilterOptions)
        sortFilterOptionsView.delegate = self
        return sortFilterOptionsView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(sortFilterOptions: SortFilterOptions) {
        self.sortFilterOptions = sortFilterOptions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SortFilterOptionsViewController {
    
    // MARK: Subview Setup
    private func setup() {
        setupSubviews()
        setupConstraints()
        
        view.backgroundColor = .doctor
        view.roundCorners(corners: .init(arrayLiteral: [.topLeft, .topRight]), radius: 15)
    }
    
    private func setupSubviews() {
        view.addSubview(sortFilterOptionsView)
    }
    
    private func setupConstraints() {
        sortFilterOptionsView.fillSuperView()
    }
}

extension SortFilterOptionsViewController: SortFilterOptionsViewDelegate {
    
    func didClickApplyFilterButton() {
        delegate?.didClickApplyFilterButton()
    }
}

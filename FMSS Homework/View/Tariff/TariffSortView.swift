//
//  TariffSortView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 22.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

protocol TariffSortViewDelegate: NSObjectProtocol {
    func didSelect(_ sortOption: TariffSortOption)
}

final class TariffSortView: UIView {

    private var previousCell: TariffSortViewCollectionCell?
    
    var tariffListViewModel: TariffListViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
        
    weak var delegate: TariffSortViewDelegate?
    
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sıralama Ölçütleri"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TariffSortView {
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        setupCollectionView()
    }
    
    private func setupSubviews() {
        addSubview(sectionTitleLabel)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        sectionTitleLabel.anchor(top: topAnchor,
                                     leading: leadingAnchor,
                                     bottom: nil,
                                     trailing: trailingAnchor,
                                     paddingTop: 8, paddingleft: 25, paddingBottom: 0, paddingRight: 25,
                                     width: 0, height: 0, centerX: nil, centerY: nil)
        
        collectionView.anchor(top: sectionTitleLabel.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0,
                              width: 0, height: 0, centerX: nil, centerY: nil)
    }
    
    private func setupCollectionView() {
        collectionView.register(TariffSortViewCollectionCell.self, forCellWithReuseIdentifier: TariffSortViewCollectionCell.cellIdentifier)
    }
}

extension TariffSortView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tariffListViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TariffSortViewCollectionCell.cellIdentifier,
                                                      for: indexPath) as! TariffSortViewCollectionCell
        let viewModel = tariffListViewModel?.getViewModel(at: indexPath.row)
        cell.tariffViewModel = viewModel
        if viewModel?.isSelected == true { previousCell = cell }
        return cell
    }
}
extension TariffSortView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TariffSortViewCollectionCell
        previousCell?.deselect()
        previousCell = cell
        cell.setSelected()
        guard let sortOption = cell.tariffViewModel?.sortOption else { return }
        delegate?.didSelect(sortOption)
    }
}

extension TariffSortView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthMultiplier: CGFloat = 0.25
        let width = collectionView.frame.width * widthMultiplier
        let heightMultiplier: CGFloat = 0.65
        let height = collectionView.frame.height * heightMultiplier
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}

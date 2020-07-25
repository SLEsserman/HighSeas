//
//  HomePageCompositionalController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 7/20/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import SwiftUI

class HomePageCompositionalController: UICollectionViewController {

    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in

            if sectionNumber == 0 {
                return HomePageCompositionalController.topSection()
            } else {

                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/3)))
                item.contentInsets = .init(
                    top: 0,
                    leading: 0,
                    bottom: 16,
                    trailing: 16)


                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.8),
                        heightDimension: .absolute(300)),
                    subitems: [item])


                let section                                 = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior         = .groupPaging
                section.contentInsets.leading               = 16


                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)),
                          elementKind: kind,
                          alignment: .topLeading)]
                return section
            }
        }
        super.init(collectionViewLayout: layout)
    }


    static func topSection() -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)))
        item.contentInsets.bottom               = 16
        item.contentInsets.trailing             = 16


        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(300)),
            subitems: [item])


        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior     = .groupPaging
        section.contentInsets.leading           = 16

        return section
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        0
    }


    class CompositionalHeader: UICollectionReusableView {

        let label = UILabel(
            text: "123",
            font: .boldSystemFont(ofSize: 32))

        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(label)
            label.fillSuperview()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    let headerId = "headerId"

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(
            CompositionalHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerId)

        collectionView.register(
            HomePageHeaderCell.self,
            forCellWithReuseIdentifier: "cellId")

        collectionView.register(
            HomePageRowCell.self,
            forCellWithReuseIdentifier: "smallCellId")

        collectionView.backgroundColor                              = .systemBackground
        navigationItem.title                                        = "Home Page"
        navigationController?.navigationBar.prefersLargeTitles      = true

        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefresh),
            for: .valueChanged)

        setupDiffableDataSource()
    }

    @objc fileprivate func handleRefresh() {
        collectionView.refreshControl?.endRefreshing()

        var snapshot = diffableDataSource.snapshot()
        
        snapshot.deleteSections([.productItems])
        
        diffableDataSource.apply(snapshot)
    }


    enum HomePageSection {
        case galleryItems
        case productItems
    }

    lazy var diffableDataSource: UICollectionViewDiffableDataSource<HomePageSection, AnyHashable> = .init(collectionView: self.collectionView) { (collectionView, indexPath, object) -> UICollectionViewCell? in

        if let object = object as? GalleryItem {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCellId", for: indexPath) as! HomePageHeaderCell
            cell.product = object
            return cell
        }
        return nil
    }


    @objc func handleGet(button: UIView) {

        var superview = button.superview

        while superview != nil {
            if let cell = superview as? UICollectionViewCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                guard let objectIClickedOnto = diffableDataSource.itemIdentifier(for: indexPath) else { return }

                var snapshot = diffableDataSource.snapshot()
                snapshot.deleteItems([objectIClickedOnto])
                diffableDataSource.apply(snapshot)
                print(objectIClickedOnto)
            }
            superview = superview?.superview
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = diffableDataSource.itemIdentifier(for: indexPath)
        if let object = object as? GalleryItem {
            let homePageDetailController = HomePageDetailController(appId: object.title)
            
            navigationController?.pushViewController(homePageDetailController, animated: true)
        }
    }
    
    
    private func setupDiffableDataSource() {
        
        collectionView.dataSource = diffableDataSource
        
        diffableDataSource.supplementaryViewProvider = .some({ (collectionView, kind, indexPath) -> UICollectionReusableView? in
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerId, for: indexPath) as! CompositionalHeader
            
            let snapshot = self.diffableDataSource.snapshot()
            if let object = self.diffableDataSource.itemIdentifier(for: indexPath) {
                if let section = snapshot.sectionIdentifier(containingItem: object) {
                    if section == .productItems {
                        header.label.text = "PRODUCTS"
                    }
                }
            }
            return header
        })
        
        Service.shared.fetchAllProducts { (products, err) in
            Service.shared.fetchGallery { (galleryItems, err) in
           
            
                var snapshot = self.diffableDataSource.snapshot()
                
                snapshot.appendSections([.galleryItems, .productItems])
                snapshot.appendItems(galleryItems ?? [], toSection: .galleryItems)
                snapshot.appendItems(products ?? [], toSection: .productItems)
                
                self.diffableDataSource.apply(snapshot)
            }
            
        }
    }
}


struct HomePageViews: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = HomePageCompositionalController()
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
}


struct HomePageCompositionalView_Preview: PreviewProvider {
    static var previews: some View {
        HomePageViews()
            .edgesIgnoringSafeArea(.all)
    }
}

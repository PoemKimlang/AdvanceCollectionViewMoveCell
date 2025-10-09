//
//  HomeVC.swift
//  CollectionViewMoveCell
//
//  Created by kimlang on 9/4/23.
//

import UIKit

/// Home screen with compositional layout and drag-to-reorder support
class HomeVC: UIViewController {
    
    // MARK: - Properties
    private var homeVM = HomeVM()
    private var isCanMoveCell = false
    
    // MARK: - UI Elements
    
    /// Custom header containing profile, greeting, and name
    private lazy var headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.clipsToBounds = true
        
        // Profile image
        let profileImageView = UIImageView(image: UIImage(named: "me"))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Greeting + Name labels
        let greetingLabel = UILabel()
        greetingLabel.text = greetingMessage()
        greetingLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        greetingLabel.textColor = .black
        
        let nameLabel = UILabel()
        nameLabel.text = "Poem Kimlang"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = .black
        
        let textStack = UIStackView(arrangedSubviews: [greetingLabel, nameLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        header.addSubview(profileImageView)
        header.addSubview(textStack)
        
        //        // Constraints
        NSLayoutConstraint.activate([
            
            profileImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            profileImageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            textStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            textStack.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        
        return header
    }()
    
    /// Collection view for main content
    private lazy var collectionView: UICollectionView = {
        let layout = makeLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        collectionView.register(UINib(nibName: "AccountCell", bundle: nil), forCellWithReuseIdentifier: "AccountCell")
        collectionView.register(UINib(nibName: "QuickPaymentCell", bundle: nil), forCellWithReuseIdentifier: "QuickPaymentCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Layout Setup
    private func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let rowType = self.homeVM.cells[sectionIndex].rowType
            switch rowType {
            case .HEADER:
                return HomeLayout.headerLayout()
            case .ACCOUNT:
                return HomeLayout.bankServiceLayout()
            case .QUICK_PAYMENT:
                return HomeLayout.promotionLayout()
            default:
                return HomeLayout.promotionLayout()
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupHeaderView()
        setupCollectionView()
        homeVM.initData()
        setUpGesture()
    }
    
    // MARK: - Greeting Helper
    private func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }
    
    // MARK: - Setup Layout
    
    /// Add header view to top
    private func setupHeaderView() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    /// Setup collection view below header
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Setup full-screen background behind everything
    private func setupBackgroundImage() {
        let bg = UIImageView(image: UIImage(named: "viewImg"))
        bg.contentMode = .scaleAspectFill
        bg.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bg, at: 0)
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: view.topAnchor),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
       
    }
    
    // MARK: - Gesture Handling
    private func setUpGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        collectionView.addGestureRecognizer(gesture)
    }
    
    @objc private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
            if targetIndexPath.section == 1 {
                startAnimate()
                if let cell = collectionView.cellForItem(at: targetIndexPath) {
                    UIView.animate(withDuration: 0.2) {
                        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    }
                }
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            stopAnimationOnVisibleCells()
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    // MARK: - Animation for Reorder
    private func startAnimate() {
        for indexPath in collectionView.indexPathsForVisibleItems {
            guard let cell = collectionView.cellForItem(at: indexPath) as? AccountCell else { continue }
            let shake = CABasicAnimation(keyPath: "transform.rotation")
            shake.duration = 0.15
            shake.repeatCount = .infinity
            shake.autoreverses = true
            shake.fromValue = (-2) * Double.pi / 180
            shake.toValue = (2) * Double.pi / 180
            cell.containView.layer.add(shake, forKey: "animate")
        }
    }
    
    private func stopAnimationOnVisibleCells() {
        for indexPath in collectionView.indexPathsForVisibleItems {
            if let cell = collectionView.cellForItem(at: indexPath) as? AccountCell {
                cell.containView.layer.removeAnimation(forKey: "animate")
                cell.transform = .identity
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        homeVM.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowType = homeVM.cells[section].rowType
        switch rowType {
        case .HEADER: return homeVM.cells[section].header?.count ?? 0
        case .ACCOUNT: return homeVM.cells[section].account?.count ?? 0
        case .QUICK_PAYMENT: return homeVM.cells[section].quick_paymnet?.count ?? 0
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowType = homeVM.cells[indexPath.section].rowType
        switch rowType {
        case .HEADER:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            if let data = homeVM.cells[indexPath.section].header?[indexPath.item] {
                cell.configCell(data: data)
            }
            return cell
            
        case .ACCOUNT:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as! AccountCell
            if let data = homeVM.cells[indexPath.section].account?[indexPath.item] {
                cell.configCell(data: data)
            }
            return cell
            
        case .QUICK_PAYMENT:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickPaymentCell", for: indexPath) as! QuickPaymentCell
            if let data = homeVM.cells[indexPath.section].quick_paymnet?[indexPath.item] {
                cell.configCell(data: data)
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: - Reordering Support
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        let rowType = homeVM.cells[indexPath.section].rowType
        return rowType == .ACCOUNT || rowType == .QUICK_PAYMENT
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath.section == destinationIndexPath.section else { return }
        if var items = homeVM.cells[sourceIndexPath.section].account {
            let movedItem = items.remove(at: sourceIndexPath.item)
            items.insert(movedItem, at: destinationIndexPath.item)
            homeVM.cells[sourceIndexPath.section].account = items
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return proposedIndexPath.section == originalIndexPath.section
        ? proposedIndexPath
        : originalIndexPath
    }
}

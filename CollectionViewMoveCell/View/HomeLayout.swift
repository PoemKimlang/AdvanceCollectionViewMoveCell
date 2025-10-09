//
//  HomeLayout.swift
//  CollectionViewMoveCell
//
//  Created by kimlang on 9/4/23.
//

import UIKit

/// A layout builder that defines the compositional layout structure
/// for each section in the Home screen (Header, Accounts, Promotions, etc.)
class HomeLayout {
    
    // MARK: - Header Section Layout
    
    /// Creates a layout for the **Header section**, which usually contains
    /// summary information such as balance, profile, or greeting.
    ///
    /// - Returns: A configured `NSCollectionLayoutSection` for the header.
    public static func headerLayout() -> NSCollectionLayoutSection {
        // Define a single full-width item
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        // Group takes the entire screen width, with estimated height
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(UIScreen.main.bounds.width),
            heightDimension: .estimated(150)
        )
        
        // Create a single-item vertical group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        // Create section using the group
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // no horizontal scroll
        section.contentInsets = .zero
        
        return section
    }
    
    // MARK: - Active Account Layout
    
    /// Creates a layout for the **Active Account section**, which may list
    /// account cards, balances, or transaction overviews.
    ///
    /// - Returns: A configured `NSCollectionLayoutSection` displaying vertical items.
    public static func activateLayout() -> NSCollectionLayoutSection {
        // Single item per row
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        // Estimated height allows dynamic cell sizing
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(UIScreen.main.bounds.width),
            heightDimension: .estimated(170)
        )
        
        // Group contains 3 items stacked vertically
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        
        // Section setup
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero
        
        return section
    }
    
    // MARK: - Bank Service Layout (Grid)
    
    /// Creates a **grid-style layout** used for bank services, actions, or icons.
    ///
    /// Example use: "Accounts", "Cards", "Loans", "Transfers", etc.
    ///
    /// - Parameters:
    ///   - itemInset: Padding around each grid item.
    ///   - sectionInset: Padding around the section itself.
    /// - Returns: A configured `NSCollectionLayoutSection` with a 3-column grid.
    public static func bankServiceLayout(
        itemInset: NSDirectionalEdgeInsets = .zero,
        sectionInset: NSDirectionalEdgeInsets = .zero
    ) -> NSCollectionLayoutSection {
        
        // Each item fills its grid cell
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = itemInset
        
        // Define group size (width fits screen minus margins)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(UIScreen.main.bounds.width - 32),
            heightDimension: .estimated(120)
        )
        
        // Horizontal group with 3 columns
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        // Create section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        return section
    }
    
    // MARK: - Promotion / Quick Payment Layout
    
    /// Creates a **horizontal layout** for promotional or quick-action cards.
    ///
    /// Typically displays two items side by side (e.g. Quick Payment, Quick Transfer).
    ///
    /// - Returns: A configured `NSCollectionLayoutSection` for promotions.
    public static func promotionLayout() -> NSCollectionLayoutSection {
        // Define the item (takes full height of group)
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .estimated(UIScreen.main.bounds.width),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        // Define group with estimated width and fixed height
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(UIScreen.main.bounds.width - 32),
            heightDimension: .estimated(150)
        )
        
        // Two items per horizontal group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // Create section with left padding
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        return section
    }
}

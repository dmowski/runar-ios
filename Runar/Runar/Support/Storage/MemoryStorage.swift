//
//  MemoryStorage.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/25/21.
//

import Foundation

public class MemoryStorage {
    // MARK: Props
    public static var Library: LibraryNode = LibraryNode()
    public static var GenerationRunes: [GenerationRuneModel] = []
    public static var GenerationWallpapertsStyles: [WallpapperStyleData] = []
}

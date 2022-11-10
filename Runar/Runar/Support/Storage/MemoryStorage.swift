//
//  MemoryStorage.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/25/21.
//

import Foundation

public class MemoryStorage {

    public static var library: LibraryNode = LibraryNode()
    public static var generationRunes: [GenerationRuneModel] = []
    public static var generationWallpapertsStyles: [WallpapperStyleData] = []
}

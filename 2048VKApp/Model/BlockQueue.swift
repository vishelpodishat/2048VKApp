//
//  BlockQueue.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//

import Foundation

public struct BlockQueue<T> {
    
    // MARK: - Values
    fileprivate var array = [T?]()
    fileprivate var head = 0

    public var isEmpty: Bool {
        return count == 0
    }

    public var count: Int {
        return array.count - head
    }

    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }

    // MARK: - Methods
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }

        array[head] = nil
        head += 1

        let percentage = Double(head)/Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }

        return element
    }
}

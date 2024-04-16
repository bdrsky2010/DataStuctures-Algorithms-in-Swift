import Foundation

enum AccessError: Error {
	case outOfRange
}

class Node<T> {
	public var data: T
	public var next: Node?
	public var prev: Node?
	
	init(_ data: T, next: Node? = nil, prev: Node? = nil) {
		self.data = data
		self.next = next
		self.prev = prev
	}
}

struct LinkedList<T: Equatable> {
	private var head: Node<T>?
}

import Foundation

enum AccessError: Error {
	case outOfRange
}

class Node<T> {
	public var data: T
	public var next: Node?
	
	init(_ data: T, next: Node? = nil) {
		self.data = data
		self.next = next
	}
}

/*
 제네릭 타입에 Equatable 프로토콜을 채택해주지 않으면
 Operator function '!=' requires that 'T' conform to 'Equatable'
 에러가 뜨면서 제네릭간에 == 비교를 할 수 없다고 뜸
 */
struct LinkedList<T: Equatable> {
	// 연결리스트의 첫 번째 Node를 가리키는 head
	private var head: Node<T>?
	init(head: Node<T>? = nil) {
		self.head = head
	}
	// 연결리스트의 사이즈를 카운트를 반환하는 프로퍼티
	public var count: Int {
		var cnt: Int = 0
		// head가 nil인 경우 0을 반환
		if head == nil {
			return cnt
		}
		
		// head가 nil이 아닌
		// head의 next가 존재하는 경우
		// head의 next를 계속 순회하며 count 후 반환
		var node: Node? = head
		cnt += 1
		while node?.next != nil {
			cnt += 1
			node = node?.next
		}
		return cnt
	}
	
	public var first: T? {
		if head == nil {
			return nil
		}
		return head?.data
	}
	
	public var last: T? {
		if head == nil {
			return nil
		}
		var node: Node? = head
		while node?.next != nil {
			node = node?.next
		}
		return node?.data
	}
	
	// 연결리스트가 비었는 지 유무를 반환하는 프로퍼티
	public var isEmpty: Bool {
		// head가 nil이라면 연결리스트는 비어있으니
		// true를 리턴 아니면 false를 리턴
		return head == nil ? true : false
	}
	
	// 원소를 맨 뒤에 추가해주는 메서드
	mutating func append(_ element: T) {
		// head가 비어있는 경우 Node 할당 후 head로 지정
		if head == nil {
			self.head = Node(element)
			return
		}
		
		// node가 존재할 경우
		var node: Node? = head
		while node?.next != nil {
			node = node?.next
		}
		node?.next = Node(element)
	}
	
	// 전달인자로 전달받은 index 값이 연결리스트의 마지막 인덱스보다 크면
	// outOfRange 에러를 throw 한다
	private func rangeOverIndex(_ index: Int) throws {
		guard index <= count - 1 else { throw AccessError.outOfRange }
	}
	
	mutating func insert(_ element: T, at index: Int) {
		do {
			// out of range 검사
			try rangeOverIndex(index)
			
			// 0번째 인덱스에 값이 들어온다면 헤드에 값이 들어오는 것이기 때문에
			// 새로운 node를 할당하고 새로운 node의 next는 head를 가리키고
			// head는 다시 새로운 node를 가리킨다
			if index == 0 {
				let newNode: Node = Node(element)
				newNode.next = head
				head = newNode
				return
			}
			
			// 1번째 이상의 인덱스 값이 들어온다면 해당 인덱스 - 1 만큼 iterator node로 순회하며
			// 새로운 node를 할당 후 새 node의 next는 iterator node의 next를 가리키고
			// iterator node의 next가 새 node를 가리키게 한다
			var node: Node? = head
			(1...(index - 1)).forEach { _ in
				node = node?.next
			}
			let newNode: Node = Node(element)
			newNode.next = node?.next
			node?.next = newNode
			
			// 전달받은 index 값이 마지막 node의 인덱스보다 크다면 error 출력
		} catch AccessError.outOfRange {
			print("Fatal error: Index out of range")
		} catch {
			print("Fatal error: Unknown Access")
		}
	}
	
	// 전달받은 인덱스에 해당하는 원소 제거 메서드
	mutating func remove(at index: Int) {
		// 연결리스트가 비었을 때
		guard head != nil else { return }
		do {
			try rangeOverIndex(index)
			
			if index == 0 {
				head = head?.next
			}
			
			var node: Node? = head
			(1...(index - 1)).forEach { _ in
				node = node?.next
			}
			node?.next = node?.next?.next
			
		} catch AccessError.outOfRange {
			print("Fatal error: Index out of range")
		} catch {
			print("Fatal error: Unknown Access")
		}
	}
	
	// 연결리스트의 첫 번째 원소 제거 메서드
	mutating func removeFirst() -> T? {
		// 연결리스트가 비었을 때
		if head == nil {
			return nil
		}
		guard let data: T = head?.data else { return nil }
		head = head?.next
		return data
	}
	
	// 연결리스트의 마지막 원소 제거 메서드
	mutating func removeLast() -> T? {
		// 연결리스트가 비었을 때
		if head == nil {
			return nil
		}
		var node: Node? = head
		while node?.next?.next != nil {
			node = node?.next
		}
		guard let data = node?.next?.data else { return nil }
		node?.next = node?.next?.next
		return data
	}
	
	func forEach(_ body: (T) -> Void) {
		guard head != nil else { return }
		var node: Node? = head
		for _ in 0...count - 1 {
			guard let data = node?.data else { return }
			body(data)
			node = node?.next
		}
	}
	
	func show() {
		if head == nil { print(head) }
		else {
			var node = head
			var list: [T] = []
			while node?.next != nil {
				guard let data = node?.data else { return }
				list.append(data)
				node = node?.next
			}
			guard let data = node?.data else { return }
			list.append(data)
			print(list)
		}
	}
}
var list: LinkedList = LinkedList<Int>()
list.show()
(1...10).forEach { _ in list.append(Int.random(in: (1...20))) }
print(list.count)
list.show()
list.insert(100, at: 2)
list.show()
list.remove(at: 10)
list.show()
print(list.removeFirst())
list.show()
print(list.removeLast())
list.show()
list.forEach {
	print($0)
}

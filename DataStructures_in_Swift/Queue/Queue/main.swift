import Foundation

struct Queue<T> {
	// Queue를 선형 형태로 저장하는 프로퍼티
	private var queue: [T] = []
	
	// Queue 크기를 반환하는 프로퍼티
	public var count: Int {
		return queue.count
	}
	
	// Queue가 비어있는지 유무를 반환하는 프로퍼티
	public var isEmpty: Bool {
		return queue.isEmpty
	}
	
	// Queue의 첫 원소를 반환하는 프로퍼티
	public var firstEl: T? {
		return queue.first
	}
	
	// Queue의 원소 전체 삭제 메서드
	mutating func clear() {
		queue.removeAll()
	}
	
	// Queue의 마지막에 원소를 추가하는 메서드
	mutating func enqueue(_ el: T) {
		queue.append(el)
	}
	
	// Queue의 첫 원소를 삭제 후 반환하는 메서드
	mutating func dequeue() -> T? {
		return isEmpty ? nil : queue.removeFirst()
	}
}

var q = Queue<Int>()
print(q.dequeue())
(1...10).forEach{ q.enqueue($0) }
print(q.isEmpty)
print(q.count)
print(q.firstEl)
print(q.dequeue())
print(q.clear())
print(q.isEmpty)

//
//  MainPresenter.swift
//  RouterPattern
//
//  Created by Amirreza Eghtedari on 2/15/1400 AP.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
	
	var dataSource = [StudentViewModel]()
	weak var delegate: MainPresenterDelegate?
	let interactor: MainInteractorProtocol
	
	init(interactor: MainInteractorProtocol) {
		self.interactor = interactor
	}
	
	func loadStudents() {
		interactor.load()
	}
	
	func numberOfRowsIn(section: Int) -> Int {
		dataSource.count
	}
	
	func studentForRowAt(indexPath: IndexPath) -> StudentViewModel? {
		guard indexPath.row < dataSource.count else { return nil }
		return dataSource[indexPath.row]
	}
	
	func edit(student id: Int) {
		interactor.editStudent(id: id)
	}
}

extension MainPresenter: MainInteractorDelegate {
	
	func mainInteractorDidLoad(students: [Student]) {
		
		dataSource = students.map({ student in
			StudentViewModel(id: student.id, name: student.name)
		})
		
		delegate?.mainPresenterDidLoad()
	}

	func mainInteractorDidUpdate(studnet: Student) {
		for (i, item) in dataSource.enumerated() {
			if item.id == studnet.id {
				dataSource[i] = StudentViewModel(id: studnet.id, name: studnet.name)
				delegate?.mainPresenterDidUpdate(at: IndexPath(row: i, section: 0))
			}
		}
	}

}

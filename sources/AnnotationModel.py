# This Python file uses the following encoding: utf-8
from PySide6.QtCore import QAbstractListModel, QModelIndex, Qt, Slot

from sources.Annotation import Annotation

class AnnotationModel(QAbstractListModel):
	# defined the roles
	ID = Qt.UserRole
	IMAGE_ID = Qt.UserRole + 1
	SENTENCE = Qt.UserRole + 2
	RESPONSE = Qt.UserRole + 3
	
	def __init__(self, annotations=[]):
		super(AnnotationModel, self).__init__()
		
		self.__annotations = annotations
		
	@property
	def annotations(self):
		anns = []
		for __annotation in self.__annotations:
			anns.append(__annotation.annotation)
			
		return anns
		
	@Slot(list)
	def setAnnotations(self, annotations: list):
		# remove all former annotations
		for index in range(self.rowCount()):
			self.removeRow(0)
		
		# reset the annotations
		self.__annotations = []
		for index in range(len(annotations)):
			annotation = annotations[index]
			
			insertedRow = self.insertRow(index)
			if not insertedRow:
				raise Exception(f"Cannot insert a row at index {index}")
			
			setId = self.setData(self.index(index, 0, QModelIndex()),
										annotation.imageId(), self.ID)
			if not setId:
				raise Exception(f"Cannot set id for annotation {index}")
			
			setImageId = self.setData(self.index(index, 0, QModelIndex()),
										annotation.imageId(), self.IMAGE_ID)
			if not setImageId:
				raise Exception(f"Cannot set image id for annotation {index}")
			
			setSentence = self.setData(self.index(index, 0, QModelIndex()), 
										annotation.sentence(), self.SENTENCE)
			if not setSentence:
				raise Exception(f"Cannot set sentence for annotation {index}")
			
			setResponse = self.setData(self.index(index, 0, QModelIndex()), 
										annotation.response(), self.RESPONSE)
			if not setResponse:
				raise Exception(f"Cannot set response for annotation {index}")
			
	@Slot(int)
	def addAnnotation(self, index: int):
		self.insertRow(index+1)
	
	@Slot(int)
	def deleteAnnotation(self, index: int):
		if self.rowCount() == 1:
			self.setAnnotations([Annotation()])	
			return

		self.removeRow(index)

	def rowCount(self, parent: QModelIndex=QModelIndex()) -> int:
		return len(self.__annotations)
	
	def data(self, index: QModelIndex, role):
		if not index.isValid():
			return None
		
		if role == self.ID:
			return self.__annotations[index.row()].id()
		if role == self.IMAGE_ID:
			return self.__annotations[index.row()].id()
		if role == self.SENTENCE:
			return self.__annotations[index.row()].sentence()
		if role == self.RESPONSE:
			return self.__annotations[index.row()].response()
		
		return None
	
	def setData(self, index: QModelIndex, value, role: int = Qt.EditRole) -> bool:
		if index.row() < 0 or index.row() >= self.rowCount():
			return False
		
		if role == self.ID:
			self.__annotations[index.row()].setId(value)
			self.dataChanged.emit(index, index)
			return True
		
		if role == self.IMAGE_ID:
			self.__annotations[index.row()].setImageId(value)
			self.dataChanged.emit(index, index)
			return True
		
		if role == self.SENTENCE:
			self.__annotations[index.row()].setSentence(value)
			self.dataChanged.emit(index, index)
			return True
		
		if role == self.RESPONSE:
			self.__annotations[index.row()].setResponse(value)
			self.dataChanged.emit(index, index)
			return True
		
		return False
	
	def insertRow(self, row: int, parent: QModelIndex=QModelIndex()) -> bool:
		if row < 0 or row > self.rowCount():
			return False
		
		self.beginInsertRows(parent, row, row)
		self.__annotations.insert(row, Annotation())
		self.endInsertRows()
		
		return True

	def removeRow(self, row: int, parent: QModelIndex=QModelIndex()) -> bool:
		if row < 0 or row >= self.rowCount():
			return False
		
		self.beginRemoveRows(parent, row, row)
		self.__annotations.pop(row)
		self.endRemoveRows()
		
		return True
		
	def roleNames(self):
		return {
			self.ID: b"id",
			self.SENTENCE: b"sentence",
			self.RESPONSE: b"response"
		}

	def flags(self, index: QModelIndex):
		if not index.isValid():
			return Qt.ItemIsEnabled
		return super().flags(index) | Qt.ItemIsEditable

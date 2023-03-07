# This Python file uses the following encoding: utf-8
from PySide6.QtCore import QAbstractListModel, QModelIndex, Qt

class AnnotationModel(QAbstractListModel):
	# defined the roles
	SENTENCE = Qt.UserRole
	RESPONSE = Qt.UserRole + 1
	
	def __init__(self, annotations=[]):
		super(AnnotationModel, self).__init__()
		
		self.__annotations = annotations
		
		def rowCount(self) -> int:
			return len(self.__annotations)
		
		def data(self, index: QModelIndex, role):
			if index.row() <= 0 or index.row() >= self.rowCount():
				return None
			
			return self.__annotations[index.row()]
		
		def setData(self, index: QModelIndex, value, role: int) -> bool:
			if index.row() <= 0 or index.row() >= self.rowCount():
				return False
			
			if role == self.ANNOTATION:
				self.__annotations[index.row()]["sentence"] = value.toString()
				return True
			
			if role == self.RESPONSE:
				self.__annotations[index.row()]["response"] = value.toString()
				return True
			
			return False
		
		def insertRow(self, row: int, parent: QModelIndex) -> bool:
			if row <= 0 or row >= self.rowCount():
				return False
			
			self.beginInsertRows(parent, row, row+1)
			self.__annotations[row] = {
				"sentence": "",
				"response": None
			}
			self.endInsertRows()
	
		def removeRow(self, row: int, parent: QModelIndex) -> bool:
			if row <= 0 or row >= self.rowCount():
				return False
			
			self.beginRemoveRows(parent, row, row+1)
			self.__annotations[row].pop(row)
			self.endRemoveRows()
			
		def roleNames(self):
			return {
				self.SENTENCE: b"sentence",
				self.RESPONSE: b"response"
			}
		
		def flags(self, index: QModelIndex):
			if index.row() <= 0 or index.row() >= self.rowCount():
				return Qt.NoItemFlags
			
			return Qt.ItemIsEditable
		
		@property
		def annotations(self):
			return self.__annotations

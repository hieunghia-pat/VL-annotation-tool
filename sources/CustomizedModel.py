from PySide6.QtCore import QAbstractListModel, QModelIndex, QObject, Slot

class CustomizedModel(QAbstractListModel):
	def __init__(self, parent: QObject):
		super(CustomizedModel, self).__init__()
		
		self.__internalData = [1, 2, 3, 4, 5]
		
	def rowCount(self, parent: QModelIndex = QModelIndex()) -> int:
		return len(self.__internalData)
	
	def data(self, index: QModelIndex, role: int):
		return self.__internalData[index.row()]
	

import json
import os

from PySide6.QtCore import QObject, Signal, Slot, QStandardPaths, Property

class Model(QObject):

	# signals
	selectedFolderToOpenChanged = Signal(str)
	selectedFolderToSaveChanged = Signal(str)
	openFolderError = Signal(str)
	openNewFolder = Signal(None)
	loadedData = Signal(None)

	def __init__(self, parent: QObject):
		super(Model, self).__init__(parent)

		# private members
		self.__data = {}
		self.__selectedFolderToOpen = QStandardPaths.standardLocations(QStandardPaths.DocumentsLocation)[0]
		self.__selectedFolderToSave = QStandardPaths.standardLocations(QStandardPaths.DocumentsLocation)[0]

	# Q_PROPERTIES
	@Property(str)
	def selectedFolderToOpen(self) -> str:
		return self.__selectedFolderToOpen

	@Property(str)
	def selectedFolderToSave(self) -> str:
		return self.__selectedFolderToSave

	# slots
	@Slot(str, result=None)
	def setSelectedFolderToOpen(self, selectedFolderToOpen: str) -> None:
		self.__selectedFolderToOpen = selectedFolderToOpen
		self.__load_data()

	@Slot(str, result=None)
	def setSelectedFolderToSave(self, selectedFolderToSave: str) -> None:
		self.__selectedFolderToSave = selectedFolderToSave

	# private methods
	def __load_data(self) -> bool:
		try:
			tmp_data = json.load(open(os.path.join(self.__selectedFolderToOpen, "annotation.json")))
		except FileNotFoundError:
			self.openNewFolder.emit()
			return True
		except Exception as error:
			self.openFolderError.emit(error.strerror)
			return False

		self.__data = tmp_data

		return True

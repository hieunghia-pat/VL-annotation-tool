import json
import os

from PySide6.QtCore import QObject, Signal, Slot, QStandardPaths, Property

from sources.AnnotationModel import AnnotationModel

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
		self.__currentIndex = 0
		self.__annotationModel = None
		self.__selectedFolderToOpen = QStandardPaths.standardLocations(QStandardPaths.DocumentsLocation)[0]
		self.__selectedFolderToSave = QStandardPaths.standardLocations(QStandardPaths.DocumentsLocation)[0]

	# Q_PROPERTIES
	@Property(str)
	def selectedFolderToOpen(self) -> str:
		return self.__selectedFolderToOpen

	@Property(str)
	def selectedFolderToSave(self) -> str:
		return self.__selectedFolderToSave
	
	def __len__(self):
		return len(self.__data["images"])
	
	@Slot(None, result=None)
	def annotations(self):
		imageId = self.__data["images"][self.__currentIndex]["id"]
		anns = []
		for ann in self.__data["annotations"]:
			if ann["image_id"] == imageId:
				anns.append(ann)
				
		self.__annotationModel = AnnotationModel(anns)
		
		return self.__annotationModel
	
	@Slot(None, result=None)
	def updateAnnotations(self):
		anns = self.__annotationModel.annotations
		for ann in anns:
			for ith in len(self.__data["annotations"]):
				if self.__data["annotations"][ith]["id"] == ann["id"]:
					self.__data["annotations"][ith] = ann

	# slots
	@Slot(str, result=None)
	def setSelectedFolderToOpen(self, selectedFolderToOpen: str) -> None:
		self.__selectedFolderToOpen = selectedFolderToOpen
		self.__load_data()

	@Slot(str, result=None)
	def setSelectedFolderToSave(self, selectedFolderToSave: str) -> None:
		self.__selectedFolderToSave = selectedFolderToSave
		
	@Slot(int, result=None)
	def addAnnotation(self, index: int) -> None:
		print(index)
		
	@Slot(int, result=None)
	def deleteAnnotation(self, index: int) -> None:
		print(index)
		
	@Slot(int, result=None)
	def addAnnotationResponse(self, index: int) -> None:
		print(index)
	
	@Slot(None, result=None)
	def nextImage(self) -> None:
		self.updateAnnotations()
		self.__currentIndex = (self.__currentIndex + 1) % len(self)
		
	def previousImage(self) -> None:
		self.updateAnnotations()
		self.__currentIndex = max((self.__currentIndex - 1), 0)

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

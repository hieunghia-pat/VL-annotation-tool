import json
import os
import re

from PySide6.QtCore import QObject, Signal, Slot, QStandardPaths, Property

from sources.Annotation import Annotation

class Backend(QObject):

	# signals
	selectedFolderToOpenChanged = Signal(str)
	selectedFolderToSaveChanged = Signal(str)
	openFolderError = Signal(str)
	openNewFolder = Signal(None)
	loadedData = Signal(list)

	def __init__(self, parent: QObject):
		super(Backend, self).__init__(parent)

		# private members
		self.__data = {}
		self.__currentIndex = 0
		self.__selectedFolderToOpen = QStandardPaths.standardLocations(QStandardPaths.DocumentsLocation)[0]
		self.__selectedFolderToSave = QStandardPaths.standardLocations(QStandardPaths.DocumentsLocation)[0]

	# Q_PROPERTIES
	@Property(str)
	def selectedFolderToOpen(self) -> str:
		return self.__selectedFolderToOpen

	@Property(str)
	def selectedFolderToSave(self) -> str:
		return self.__selectedFolderToSave
	
	@property
	def annotations(self) -> list:
		anns = []
		image_id = self.__data["images"][self.__currentIndex]["id"]
		for ann in self.__data["annotations"]:
			if ann["image_id"] == image_id:
				anns.append(Annotation(ann))
				
		return anns
	
	def __len__(self):
		return len(self.__data["images"])
	
	@Slot(None, result=None)
	def updateAnnotations(self):
		anns = self.annotationModel.annotations
		for ann in anns:
			for ith in len(self.__data["annotations"]):
				if self.__data["annotations"][ith]["id"] == ann["id"]:
					self.__data["annotations"][ith] = ann

	@Slot(str, result=None)
	def setSelectedFolderToOpen(self, selectedFolderToOpen: str) -> None:
		self.__selectedFolderToOpen = self.__preprocessPath(selectedFolderToOpen)
		self.__loadData()

	@Slot(str, result=None)
	def setSelectedFolderToSave(self, selectedFolderToSave: str) -> None:
		self.__selectedFolderToSave = self.__preprocessPath(selectedFolderToSave)
		
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
		self.loadedData.emit(self.annotations)
	
	@Slot(None, result=None)
	def previousImage(self) -> None:
		self.updateAnnotations()
		self.__currentIndex = max((self.__currentIndex - 1), 0)
		self.loadedData.emit(self.annotations)
		
	def data(self):
		return self.__data
	
	# private methods
	def __preprocessPath(self, path: str) -> str:
		path = re.sub("file://", "", path)
		
		return path
		
	def __loadData(self) -> bool:
		try:
			tmpData = json.load(open(os.path.join(self.__selectedFolderToOpen, "annotation.json")))
		except FileNotFoundError:
			# when opening a new folder, set the self.__data to empty w.r.t total number 
			# of images available in the folder
			tmpData = {
				"images": [],
				"annotations": []
			}
			image_id = 0
			files = os.listdir(self.selectedFolderToOpen)
			for file in files:
				if file.split(".")[-1] in ["jpq", "jpeg", "png"]: # only accept the jpeg, jpg and pnd images
					image_id += 1
					tmpData["images"].append({
						"filename": file,
						"id": image_id
					})
					tmpData["annotations"].append({
						"image_id": image_id,
						"sentence": "",
						"response": ""
					})
			json.dump(tmpData, open(
				os.path.join(self.selectedFolderToOpen, "annotation.json"), "w+"
			))
			self.openNewFolder.emit()
		except Exception as error:
			self.openFolderError.emit(error.strerror)
			return False

		self.__data = tmpData
		self.loadedData.emit(self.annotations)

		return True

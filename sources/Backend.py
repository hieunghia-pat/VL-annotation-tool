import json
import os
import re

from PySide6.QtCore import QObject, Signal, Slot, Property, QDir

from sources.Annotation import Annotation

class Backend(QObject):

	def __init__(self, annotationModel, parent: QObject):
		super(Backend, self).__init__(parent)

		# private members
		self.__data = []
		self.__currentIndex = 0
		self.__selectedFolderToOpen = QDir.currentPath()
		self.__annotationModel = annotationModel

	loadedAnnotations = Signal(list)
	openNewFolder = Signal(None)
	selectedFolderToOpenChanged = Signal(str)
	selectedFolderToSaveChanged = Signal(str)
	openFolderError = Signal(str)
	
	@Property(str)
	def selectedFolderToOpen(self) -> str:
		return self.__selectedFolderToOpen
	
	@selectedFolderToOpen.setter
	def selectedFolderToOpen(self, selectedFolder: str):
		self.__selectedFolderToOpen = selectedFolder
	
	# get annotations from internal data
	def annotations(self) -> list:
		anns = self.__data[self.__currentIndex]["annotations"]
		anns = [Annotation(ann) for ann in anns]

		return anns

	@Property(str)
	def image(self):
		if len(self.__data) == 0:
			return "../media/no-image.png"
		
		url = self.__data[self.__currentIndex]["filename"]
		url = os.path.join(self.selectedFolderToOpen, url)

		return url
	
	def __len__(self):
		return len(self.__data)
	
	# update new annotations from the model
	@Slot(None, result=None)
	def updateAnnotations(self):
		anns = self.__annotationModel.annotations()
		self.__data[self.__currentIndex]["annotations"] = anns

	@Slot(str, result=None)
	def setSelectedFolderToOpen(self, selectedFolderToOpen: str) -> None:
		self.__selectedFolderToOpen = self.__preprocessPath(selectedFolderToOpen)
		self.__loadData()
	
	@Slot(None, result=None)
	def nextImage(self) -> None:
		self.updateAnnotations()
		self.__currentIndex = min(self.__currentIndex + 1, len(self)-1)
		self.loadedAnnotations.emit(self.annotations())
	
	@Slot(None, result=None)
	def previousImage(self) -> None:
		self.updateAnnotations()
		self.__currentIndex = max((self.__currentIndex - 1), 0)
		self.loadedAnnotations.emit(self.annotations())
		
	@Slot(None)
	def data(self):
		return self.__data
	
	@Slot(None)
	def saveData(self) -> bool:
		self.updateAnnotations()
		json.dump(self.__data, open(os.path.join(self.__selectedFolderToOpen, "annotation.json"), "w+"))
	
	# private methods
	def __preprocessPath(self, path: str) -> str:
		path = re.sub("file://", "", path)
		
		return path
		
	def __loadData(self) -> bool:
		try:
			tmpData = json.load(open(os.path.join(self.selectedFolderToOpen, "annotation.json")))
		except FileNotFoundError:
			# when opening a new folder, set the self.__data to empty w.r.t total number 
			# of images available in the folder
			tmpData = []
			files = os.listdir(self.selectedFolderToOpen)
			for file in files:
				if file.split(".")[-1] in ["jpg", "jpeg", "png"]: # only accept the jpeg, jpg and pnd images
					tmpData.append({
						"filename": file,
						"annotations": []
					})
			json.dump(tmpData, open(
				os.path.join(self.selectedFolderToOpen, "annotation.json"), "w+"
			))
			self.openNewFolder.emit()
		except Exception as error:
			self.openFolderError.emit(error.strerror)
			return False

		self.__data = tmpData
		self.loadedAnnotations.emit(self.annotations())

		return True

import json
import os
import re

from PySide6.QtCore import QObject, Signal, Slot, Property, QDir

from sources.Annotation import Annotation

EMPTY_DATA = {
	"images": [],
	"annotations": []
}

class Backend(QObject):

	def __init__(self, annotationModel, parent: QObject):
		super(Backend, self).__init__(parent)

		# private members
		self.__data = EMPTY_DATA
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
	
	@Property(list)
	def annotations(self) -> list:
		anns = []
		image_id = self.__data["images"][self.__currentIndex]["id"]
		for ann in self.__data["annotations"]:
			if ann["image_id"] == image_id:
				anns.append(Annotation(ann))
				
		return anns

	@Property(str)
	def image(self):
		if len(self.__data["images"]) == 0:
			return "../media/no-image.png"
		
		url = self.__data["images"][self.__currentIndex]["filename"]
		url = os.path.join(self.selectedFolderToOpen, url)

		return url
	
	def __len__(self):
		return len(self.__data["images"])
	
	@Slot(None, result=None)
	def updateAnnotations(self):
		anns = self.__annotationModel.annotations
		for ann in anns:
			for ith in range(len(self.__data["annotations"])):
				if self.__data["annotations"][ith]["id"] == ann["id"]:
					self.__data["annotations"][ith]["sentence"] = ann["sentence"]
					self.__data["annotations"][ith]["response"] = ann["response"]
					continue

	@Slot(str, result=None)
	def setSelectedFolderToOpen(self, selectedFolderToOpen: str) -> None:
		self.__selectedFolderToOpen = self.__preprocessPath(selectedFolderToOpen)
		self.__loadData()
	
	@Slot(None, result=None)
	def nextImage(self) -> None:
		self.updateAnnotations()
		self.__currentIndex = (self.__currentIndex + 1) % len(self)
		self.loadedAnnotations.emit(self.annotations)
		self.nextImageSignal.emit()
	
	@Slot(None, result=None)
	def previousImage(self) -> None:
		self.updateAnnotations()
		self.__currentIndex = max((self.__currentIndex - 1), 0)
		self.loadedAnnotations.emit(self.annotations)
		self.previousImageSignal.emit()
		
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
			tmpData = EMPTY_DATA
			image_id = 0
			files = os.listdir(self.selectedFolderToOpen)
			annId = 0
			for file in files:
				if file.split(".")[-1] in ["jpq", "jpeg", "png"]: # only accept the jpeg, jpg and pnd images
					image_id += 1
					tmpData["images"].append({
						"filename": file,
						"id": image_id
					})
					tmpData["annotations"].append({
						"id": annId,
						"image_id": image_id,
						"sentence": "",
						"response": ""
					})
					annId += 1
			json.dump(tmpData, open(
				os.path.join(self.selectedFolderToOpen, "annotation.json"), "w+"
			))
			self.openNewFolder.emit()
		except Exception as error:
			self.openFolderError.emit(error.strerror)
			return False

		self.__data = tmpData
		self.loadedAnnotations.emit(self.annotations)

		return True

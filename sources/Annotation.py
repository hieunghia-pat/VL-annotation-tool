# This Python file uses the following encoding: utf-8
from PySide6.QtCore import QObject, Signal, Slot

class Annotation(QObject):
	
	idChanged = Signal(str)
	sentenceChanged = Signal(str)
	responseChanged = Signal(str)
	
	def __init__(self, annotation={
		"id": 0,
		"image_id": None,
		"sentence": "",
		"response": ""
	}):
		super(Annotation, self).__init__()
		
		self.__id = annotation["id"]
		self.__imageId = annotation["image_id"]
		self.__sentence = annotation["sentence"]
		self.__response = annotation["response"]
		
	def id(self):
		return self.__id
	
	def imageId(self):
		return self.__imageId
		
	def sentence(self):
		return self.__sentence
	
	def response(self):
		return self.__response
	
	@property
	def annotation(self):
		return {
			"id": self.id(),
			"image_id": self.imageId(),
			"sentence": self.sentence(),
			"response": self.response()
		}
	
	@Slot(int)
	def setId(self, id):
		self.__id = id
		
	@Slot(int)
	def setImageId(self, imageId):
		self.__imageId = imageId
	
	@Slot(str)
	def setSentence(self, sentence):
		self.__sentence = sentence
	
	@Slot(str)	
	def setResponse(self, response):
		self.__response = response

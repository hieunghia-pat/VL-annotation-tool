# This Python file uses the following encoding: utf-8
from PySide6.QtCore import QObject, Signal, Slot

class Annotation(QObject):
	
	sentenceChanged = Signal(str)
	responseChanged = Signal(str)
	
	def __init__(self, annotation={
		"sentence": "",
		"response": ""
	}):
		super(Annotation, self).__init__()
		
		self.__sentence = annotation["sentence"]
		self.__response = annotation["response"]
		
	def sentence(self):
		return self.__sentence
	
	def response(self):
		return self.__response
	
	def annotation(self):
		return {
			"sentence": self.sentence(),
			"response": self.response()
		}
	
	@Slot(str)
	def setSentence(self, sentence):
		self.__sentence = sentence
	
	@Slot(str)	
	def setResponse(self, response):
		self.__response = response

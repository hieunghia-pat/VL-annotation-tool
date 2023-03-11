# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from sources.Annotation import Annotation
from sources.Backend import Backend
from sources.AnnotationModel import AnnotationModel

if __name__ == "__main__":
	app = QGuiApplication(sys.argv)

	annotationModel = AnnotationModel()
	backend = Backend(annotationModel, app)

	engine = QQmlApplicationEngine()

	engine.rootContext().setContextProperty("backend", backend)
	engine.rootContext().setContextProperty("annotationModel", annotationModel)
	
	backend.loadedAnnotations.connect(annotationModel.setAnnotations)

	qml_file = Path(__file__).resolve().parent / "main.qml"
	engine.load(qml_file)

	if not engine.rootObjects():
		sys.exit(-1)

	sys.exit(app.exec())

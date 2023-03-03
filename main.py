# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from sources.Model import Model

if __name__ == "__main__":
	app = QGuiApplication(sys.argv)

	model = Model(app)

	engine = QQmlApplicationEngine()

	engine.rootContext().setContextProperty("model", model)

	qml_file = Path(__file__).resolve().parent / "main.qml"
	engine.load(qml_file)

	if not engine.rootObjects():
		sys.exit(-1)

	sys.exit(app.exec())

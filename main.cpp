#include <VPApplication>
#include <QApplication>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{

  QApplication app(argc, argv);

  VPApplication vplay;

  // QQmlApplicationEngine is the preffered way to start qml projects since Qt 5.2
  // if you have older projects using Qt App wizards from previous QtCreator versions than 3.1, please change them to QQmlApplicationEngine
  QQmlApplicationEngine engine;
  vplay.initialize(&engine);

  // use this instead of the below call for faster deployment on desktop when you comment the RESOURCES in the .pro file (this avoids compiling all your resources into the binary and has shorter compile times; also it allows re-running the same project in non-shadow builds)
  // this is the preferred deployment option during development on Desktop (for deployment on mobile use the qrc approach below)
  vplay.setMainQmlFileName(QStringLiteral("qml/FlappyBirdMain.qml"));

  // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
  // this is the preferred deployment option for debug and release builds on mobile, and for publish builds on all platforms
  // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
  // only use the above non-qrc approach, during development on desktop
//  vplay.setMainQmlFileName(QStringLiteral("qrc:/qml/FlappyBirdMain.qml"));

  // there only are sd graphics for FlappyBird to keep retro style, so set the content scale to 1
  vplay.setContentScaleAndFileSelectors(1);

  engine.load(QUrl(vplay.mainQmlFileName()));

  return app.exec();
}

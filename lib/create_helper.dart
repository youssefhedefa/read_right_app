import 'dart:io';

void createFeatureFolder(String featureName) {
  final baseDir = Directory('lib/features/$featureName');
  final dataDir = Directory('${baseDir.path}/data');
  final domainDir = Directory('${baseDir.path}/domain');
  final presentationDir = Directory('${baseDir.path}/presentation');
  final uiDir = Directory('${presentationDir.path}/ui');
  final widgetsDir = Directory('${presentationDir.path}/ui/widgets');
  final managerDir = Directory('${presentationDir.path}/manager');

  // create feature view file
  final featureViewFile = File('${uiDir.path}/${featureName}_view.dart');
  if (!featureViewFile.existsSync()) {
    featureViewFile.createSync();
  }
  // Create the base feature directory
  if (!baseDir.existsSync()) {
    baseDir.createSync(recursive: true);
  }

  // Create the data, domain, and presentation directories
  if (!dataDir.existsSync()) {
    dataDir.createSync(recursive: true);
  }
  if (!domainDir.existsSync()) {
    domainDir.createSync(recursive: true);
  }
  if (!presentationDir.existsSync()) {
    presentationDir.createSync(recursive: true);
  }
  if (!uiDir.existsSync()) {
    uiDir.createSync(recursive: true);
  }
  if (!managerDir.existsSync()) {
    managerDir.createSync(recursive: true);
  }
  if (!widgetsDir.existsSync()) {
    widgetsDir.createSync(recursive: true);
  }

  print('Feature folder structure created for $featureName');
}

cubitBuilder({required String name,required String featureName}) {
  //create folder for cubit and state

  final cubitName = '${name}_cubit.dart';
  final stateName = '${name}_state.dart';

  final cubitFile = File('lib/features/$featureName/presentation/manager/$cubitName');
  final stateFile = File('lib/features/$featureName/presentation/manager/$stateName');
  // create the files
  if (!cubitFile.existsSync()) {
    cubitFile.createSync();
  }
  if (!stateFile.existsSync()) {
    stateFile.createSync();
  }

}

void main() {
  // createFeatureFolder('library');
  cubitBuilder(name: 'get_saved_books',featureName: 'library');
}
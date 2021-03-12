import 'package:fish_redux/fish_redux.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

//TODO replace with your own action
enum PublishAction { action, init, openGallery, upDateImages, onPublish }

class PublishActionCreator {
  static Action onAction() {
    return const Action(PublishAction.action);
  }

  static Action onInit() {
    return const Action(PublishAction.init);
  }

  static Action onOpenGallery() {
    return const Action(PublishAction.openGallery);
  }

  static Action upDateImages(List<Asset> newImages) {
    return Action(PublishAction.upDateImages, payload: newImages);
  }

  static Action onPublish() {
    return const Action(PublishAction.onPublish);
  }
}

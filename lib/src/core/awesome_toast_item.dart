import 'package:awesome_toast/src/widget/toast_envelope.dart';
import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';

/// [AwesomeToastItem] représente un élément toast qui peut être affiché à l'écran.
/// Cette classe gère :
/// - La construction du widget toast à travers [builder].
/// - Une durée automatique avant la fermeture via [autoCloseDuration].
/// - Une action spécifique à effectuer lors de la fermeture automatique via [onAutoClose].
///
/// ### Propriétés :
/// - [builder] : Le widget qui définit l'apparence de la toast.
/// - [autoCloseDuration] : La durée après laquelle la toast se ferme automatiquement.
///   - Si `null`, la toast restera affichée jusqu'à ce qu'une action explicite la supprime.
/// - [onAutoClose] : Fonction appelée lorsque la toast se ferme automatiquement.
/// - [id] : Identifiant unique pour différencier chaque toast.
///
/// ### Fonctionnalités :
/// - Si [autoCloseDuration] est spécifié, un [PausableTimer] est initialisé pour gérer
///   la fermeture automatique après la durée définie.
/// - Les méthodes [startTimer] et [stopTimer] permettent de contrôler le timer, 
///   respectivement pour démarrer ou mettre en pause la fermeture automatique.
///
/// ### Widget Enveloppé :
/// La propriété [toast] retourne un widget enveloppé dans [AwesomeToastEnvelope],
/// qui est responsable des animations et des actions associées à la toast.

class AwesomeToastItem {
  final Widget builder;
  final Duration? autoCloseDuration;
  final void Function(AwesomeToastItem item)? onAutoClose;
  AwesomeToastItem({
    required this.builder,
    this.autoCloseDuration,
    required this.onAutoClose,
  }) : id = UniqueKey().toString() {
    print(autoCloseDuration);
    if (autoCloseDuration != null) {
      _timer = PausableTimer(
        autoCloseDuration!,
        () => onAutoClose?.call(this),
      );
      startTimer();
    }
  }

  Widget get toast => AwesomeToastEnvelope(item: this);

  late PausableTimer _timer;
  final String id;

  void startTimer() {
    _timer.start();
  }

  void stopTimer() {
    _timer.pause();
  }
}

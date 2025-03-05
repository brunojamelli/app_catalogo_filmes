import 'package:app_catalogo_filmes/models/filme.dart';
import 'package:app_catalogo_filmes/widgets/filme_card.dart';
import 'package:flutter/material.dart';

class AnimatedFilmeCard extends StatelessWidget {
  final Filme filme;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final int index;

  const AnimatedFilmeCard({
    required this.filme,
    required this.onTap,
    required this.onLongPress,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 500 + (index * 100)), // Atraso progressivo
      child: FilmeCard(
        filme: filme,
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
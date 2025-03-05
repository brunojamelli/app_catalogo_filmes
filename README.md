# app_catalogo_filmes

Um aplicativo Flutter para gerenciar e visualizar informações sobre filmes, como título, ano, direção, resumo, cartaz e avaliação.

## Funcionalidades

- **Listagem de filmes**: Exibe os filmes em um layout de grade com cartaz, título, ano, direção, resumo e avaliação.
- **Cadastro e edição de filmes**: Permite adicionar ou editar filmes com informações detalhadas.
- **Avaliação com estrelas**: Usa um sistema de avaliação com estrelas para classificar os filmes.
- **Cartaz aleatório**: Gera URLs de cartazes de filmes aleatórios usando imagens do TMDb.

## Estrutura do Projeto

Aqui está a organização dos arquivos do projeto:

```markdown
lib/
├── main.dart
├── models/
│ └── filme.dart
├── services/
│ └── database.dart
├── widgets/
│ ├── filme_card.dart
│ ├── custom_app_bar.dart
│ └── animated_filme_card.dart
└── screens/
├── home_screen.dart
└── cadastro_screen.dart
```

---
### Descrição dos Arquivos
- **main.dart**: Ponto de entrada do aplicativo.
- **models/**: Contém a classe de modelo para os filmes.
- **services/**: Contém a lógica de acesso ao banco de dados.
- **widgets/**: Widgets reutilizáveis para a interface do usuário.
- **screens/**: Contém as telas do aplicativo.

---

## Como Executar o Projeto

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/app_catalogo_filmes.git
```

```bash
cd app_catalogo_filmes
```

```bash
flutter pub get
```

```bash
flutter run
```
## Dependências
O projeto utiliza as seguintes dependências:

- **sqflite**: Para armazenamento local dos filmes.
- **flutter/material.dart**: Para a interface do usuário.
- **path**: Para acesso as pastas do dispositivo.
- **flutter_rating_bar**: Para o sistema de avaliação com estrelas.
- **http**: Para fazer requisições à API.
- **flutter_native_splash**: Para automatizar o processo de configuração de uma imagem personalizada como splashscreen.
- **flutter_launcher_icons**: Para automatizar o processo de configuração de uma imagem personalizada co ícone.

# 💈 BarberHub

Um aplicativo desenvolvido em **Flutter** para gerenciamento de agendamentos em barbearias, oferecendo uma experiência otimizada tanto para clientes quanto para barbeiros e administradores.

---

## 👥 Autores

- **Guilherme Batista Correia** - [GitHub](https://github.com/Guizeraaaa)
- **Emanuel Derossi** - [GitHub](https://github.com/emanuelderossi)
- **Lucas Ramos dos Santos** - [GitHub](https://github.com/LucasRDS2007)

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

Antes de começar, certifique-se de ter instalado em sua máquina:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Versão compatível com o projeto)
- [Dart SDK](https://dart.dev/get-started)
- IDE de sua preferência ([VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio))
- Emulador Android/iOS ou dispositivo físico configurado

### Passos para execução

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/Guizeraaaa/BarberHub.git
   ```

2. **Instale as dependências:**

   ```bash
   flutter pub get
   ```

3. **Execute a aplicação:**
   ```bash
   flutter run
   ```

---

## ✨ Resumo de Features

### 👤 Módulo do Cliente

- **Autenticação:** Tela de login e gerenciamento de perfis baseados em papéis (`Role.client` e `Role.barber`).
- **Agendamento:** Seleção de horários disponíveis via componente customizado de _slots_ de data e hora.
- **Histórico & Gestão de Agendamentos:** Visualização de agendamentos e cancelamento.
- **Lista de Barbeiros & Detalhes:** Visualização e busca de profissionais disponíveis na barbearia.
- **Catálogo de Serviços & Detalhes:** Lista detalhada de serviços prestados.

### ✂️ Módulo do Barbeiro / Dashboard

- **Painel Analítico (Dashboard):**
  - Métricas e estatísticas do profissional (receita, quantidade de atendimentos).
  - Gráficos de barra por serviços prestados (`service_bar_chart.dart`).
  - Gráficos de rosca por status de agendamento (`status_pie_chart.dart`).
- **Gestão de Serviços:**
  - Cadastro, edição e remoção de serviços (`service_form_page.dart`).

### 🎨 Customização & UI

- **Tema Dinâmico:** Suporte a alteração de temas visual (Dark/Light Mode) com suporte a `ThemeController`.
- **Componentes Reutilizáveis:** Conjunto robusto de componentes customizados como selectores de intervalo de datas, cards com estilo hero, seletores de chip, diálogos de confirmação e filtros.
- **Dados Mockados:** Suporte para testes e desenvolvimento offline através de `mock.dart`.

---

## 🛠️ Tecnologias e Libs Utilizadas

- **Linguagem:** [Dart](https://dart.dev/).
- **Framework Mobile:** [Flutter](https://flutter.dev/).
- **Gerenciamento de Estado & Controllers:** Controller pattern / StateNotifier (`Provider`).
- **Gráficos & Métricas:** Packages para renderização de gráficos (`fl_chart`).
- **Inicialização Customizadas:** Packages de Splashscreen e Icone para tela inicial (`flutter_native_splash` e `flutter_launcher_icons`).
- **Regionalização:** Packages para regionalização BR de componentes e valores monetários (`flutter_localizations` e `intl`).

---

## 🏗️ Arquitetura do Projeto

O projeto adota a arquitetura **Feature-First (Modular)** combinada com princípios de **Clean Architecture**, promovendo desacoplamento, legibilidade e facilidade na manutenção do código.

### Estrutura de Pastas (`lib/`)

```
lib/
├── features/                      # Módulos por funcionalidade (Feature-First)
│   ├── appointment/               # Gestão e listagem de agendamentos
│   │   ├── controllers/
│   │   ├── pages/
│   │   └── widgets/
│   ├── barber_dashboard/          # Dashboard e indicadores do barbeiro
│   │   ├── controllers/
│   │   ├── pages/
│   │   └── widgets/
│   ├── barber_list/               # Visualização e perfil de barbeiros
│   │   ├── controllers/
│   │   └── pages/
│   ├── home/                      # Tela principal e navegação
│   ├── login/                     # Autenticação e controle de sessão
│   ├── scheduling/                # Fluxo de agendamento de horários
│   ├── service_list/              # Cadastro e listagem de serviços
│   └── theme/                     # Controle do tema da aplicação
│
├── shared/                        # Código compartilhado entre múltiplas features
│   ├── controllers/               # Controllers globais
│   ├── mocks/                     # Dados estáticos para testes e prototipação
│   ├── models/                    # Modelos de dados (User, Barber, Appointment, Service, Role, Client)
│   ├── widgets/                   # Componentes de UI reutilizáveis (Buttons, Cards, Pickers, Dialogs)
│   ├── app_colors.dart            # Paleta de cores centralizada
│   ├── app_text_style.dart        # Estilos de tipografia
│   └── utils.dart                 # Funções utilitárias e formatadores
│
├── main.dart                      # Ponto de entrada da aplicação
└── routes.dart                    # Gerenciamento centralizado de rotas
```

---

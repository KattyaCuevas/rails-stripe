# Editorial App

Aplicación que construiremos a lo largo del curso de **Integración de Pagos en Rails con Stripe** en Código Facilito.

Esta es la primera versión de la app, la que será la base para los mini proyectos del curso.
En esta versión, tenemos una lista de artículos, los cuáles pueden ser públicos o privados. Los artículos privados por defecto no se pueden leer, pero si inicias sesión tienes acceso a estos artículos.

## Tech Stack

- Ruby 3.0.1
- Rails 6.1.4
- Yarn 1.22.10
- PostgreSQL 13.3


Gemas agregadas a Rails:

- Devise
- Pundit
- TailwindCSS-rails
- dotenv-rails
- Faker
- Stripe (en las próximas versiones)

## Correr el proyecto en local

Clonar el proyecto

```bash
  git clone git@github.com:KattyaCuevas/rails-stripe.git
```

Ir al directorio del proyecto

```bash
  cd rails-stripe
```

Instalar las dependencias

```bash
  bundle install
  yarn install
```

Preparar la base de datos:

```bash
  rails db:create
  rails db:migrate
  rails db:seed
```

Iniciar el servidor

```bash
  rails server
```

Iniciar webpacker:

```bash
  bin/webpack-dev-server
```

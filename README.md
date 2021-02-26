# Awesome

Для запуска приложения необходимо выполнить следующие команды:

```console
$ mix deps.get
$ cd assets && npm install
$ mic ecto.create && mix ecto.migrate
$ mix phx.server
```

При запуске необходимо подождать, пока соберутся данные.

Приложение будет запущено по адресу http://localhost:4000.

Запуск тестов осуществляется при помощи команды `mix test`.

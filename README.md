# README

Hobby Club - шаблон web-портала для творческих и спортивных объединений

При развертывании проекта учитывать следующие особенности

* Версия Ruby 2.5.0

* Версия Postgres > 9.6

* Система разрабатывалась на Ubuntu 16.04

* Отсутствуют требования к характеристикам оборудования, на котором запускается проект

* Создание базы данных и заполнение необходимыми данными:<br>
  rake db:create<br>
  rake db:migrate<br>
  rake db:seed

* Для написания тестов используется Rspec. Для их запуска необходимо выполнить команду rspec.

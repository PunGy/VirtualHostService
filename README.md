# VHS - Инструмент для быстрого создания виртуальных хостов
Эти скрипты преднаначены для быстрого создания и настройки виртуальных хостов на сервере Apache.
Их легко настраивать под себя и они максимально гибки для этого. **В данный момент исправная работа гарантированна лишь на дистрибутиве Ubuntu!**

## Описание файлов
### createHost.sh
Файл создает виртуальный хостинг. Принимает один параметр(имя хоста) и должен запускаться с привилегиями root (sudo).
#### Основные переменные для редактирования:
* dirHost: Директория где будет корень хоста
* logDir: Директория для log файлов
* toConf: Текст конфига хоста
* ip: IP-адрес сервера
### deleteHost.sh
Скрипт удаления виртуального хоста, для использования необходимо имя хоста в качестве параметра и root привилегии
#### Основные переменные для редактирования:
* dirHost: Директория где будет корень хоста
* logDir: Директория для log файлов

# test_specification

# Оглавление
- [Описание](#описание)
- [Задачи](#задачи)
 - [Рефакторинг класса Users::Create](#рефакторинг-класса-userscreate)
 - [Исправление опечатки в модели Skill](#исправление-опечатки-в-модели-skill)
 - [Исправление связей между моделями](#исправление-связей-между-моделями)
 - [Написание тестов](#написание-тестов)
- [Установка](#установка)
- [API Endpoints](#api-endpoints)
 - [POST /users](#post-users)
 - [POST /interests](#post-interests)
 - [POST /skills](#post-skills)

## Описание
Данный проект является решением тестового задания, 
в рамках которого была реализована логика создания 
пользователей в приложении на Ruby on Rails.
В работе был использован gem ActiveInteraction для организации бизнес-логики, 
а также произведены исправления в моделях и связях. 
Ниже описаны задачи, выполненные в ходе выполнения задания.

## Задачи
Были выполнены следующие шаги:
#### Произведен рефакторинг класса Users::Create
* Определены входные данные
* Настроены необходимые валидации
* Реализована логика создания пользователя
#### Исправлена опечатка в моделе Skill

Определены два пути решения проблемы.

Путь 1: Исправить опечатку через переименование модели и таблицы в базе данных
 В этом подходе мы изменяем имя класса с 'Skil' на 'Skill'.
 Это также требует переименования соответствующей таблицы в базе данных.
Нужно создать миграцию для переименования таблицы: rename_table :skils, :skills.
 Это более правильный и чистый способ, так как он устраняет проблему на уровне базы данных и модели.

 Путь 2: Использовать alias_attribute для создания псевдонима
 В этом случае мы оставляем имя модели как есть ('Skil'), но с помощью alias_attribute
 создаем псевдоним для атрибутов или методов, используя правильное имя ('Skill').
 Этот подход может быть полезен в случае, если вы хотите оставить старое имя модели по каким-то причинам.
 Однако это не решает проблему с названием самой модели и таблицы в базе данных.

Был выбран первый путь, как более надежный для поддержания проекта благодаря читаемости и согласованности кода.

#### Исправлены связи между моделями
* Обнаружено, что в моделях используется отношение многие-ко-многим.
* Настроены ассоциации has_many :through
* Созданы промежуточные модели

#### Написаны тесты
Проект был покрыт тестами, а именно:
* Контроллеры: UsersController, InterestsController, SkillsController
* Класс Users::Create

## Установка
Клонируйте репозиторий:

```
git clone <url>
cd <название_папки>
```

Установите зависимости:

```
bundle install
```

Поднимите базу данных:

```
rails db:create 
rails db:migrate
```
Запустите сервер:

```
rails server
```

Примените тесты:

```
bundle exec rspec
```

## API Endpoints
Access the API at http://localhost:3000
#### POST /users
Создание нового пользователя.

##### Request
Headers: Content-Type: application/json

Example Body: 

```
{
"user": {
  "name": "John",
  "patronymic": "Doe",
  "surname": "Smith",
  "email": "john.doe@example.com",
  "age": 30,
  "nationality": "American",
  "country": "USA",
  "gender": "male",
  "interests": [ "Reading", "Traveling" ],
  "skills": [ "Ruby", "Rails" ]
}
}
```

##### Response

Success (201):

```
{"user":{"id":1,"name":"John","patronymic":"Doe","surname":"Smith","email":"john.doe@example.com","age":30,"nationality":"American","country":"USA","gender":"male","interest_id":null,"skill_id":null,"created_at":"2024-12-23T13:31:19.992Z","updated_at":"2024-12-23T13:31:19.992Z"},"message":"User was successfully created."}
```

Example Error (422):

```
{
    "errors": [
        "Age 1000 is not a valid age"
    ]
}
```

#### POST /interests

Создание нового интереса.

##### Request
Headers: Content-Type: application/json

Example Body:

```
{
  "interest": {
    "name": "Reading"
  }
}
```

##### Response

Success (201):

```
{
    "interest": {
        "id": 3,
        "name": "Reading"
    },
    "message": "Interest was successfully created."
}
```

Example Error (422):

```
{
    "errors": [
        "Name can't be blank"
    ]
}
```

#### POST /skills

Создание нового навыка.

##### Request
Headers: Content-Type: application/json

Example Body:

```
{
  "skill": {
    "name": "Ruby"
  }
}
```

##### Response

Success (201):

```
{
    "skill": {
        "id": 3,
        "name": "Ruby"
    },
    "message": "Skill was successfully created."
}
```

Example Error (422):

```
{
    "errors": [
        "Name can't be blank"
    ]
}
```

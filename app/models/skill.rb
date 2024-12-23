# frozen_string_literal: true

# Путь 1: Исправить опечатку через переименование модели и таблицы в базе данных
# В этом подходе мы изменяем имя класса с 'Skil' на 'Skill'.
# Это также требует переименования соответствующей таблицы в базе данных.
# Нужно создать миграцию для переименования таблицы: rename_table :skils, :skills.
# Это более правильный и чистый способ, так как он устраняет проблему на уровне базы данных и модели.

# Путь 2: Использовать alias_attribute для создания псевдонима
# В этом случае мы оставляем имя модели как есть ('Skil'), но с помощью alias_attribute
# создаем псевдоним для атрибутов или методов, используя правильное имя ('Skill').
# Этот подход может быть полезен в случае, если вы хотите оставить старое имя модели по каким-то причинам.
# Однако это не решает проблему с названием самой модели и таблицы в базе данных.

class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills

  validates :name, presence: true
end

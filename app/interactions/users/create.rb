# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    string :name
    string :patronymic
    string :surname
    string :email
    integer :age
    string :nationality
    string :country
    string :gender
    array :interests, default: []
    array :skills, default: []

    validates :name, :patronymic, :surname, :email, :age, :nationality, :country,
              :gender, presence: true
    validates :email,
              format: { with: URI::MailTo::EMAIL_REGEXP,
                        message: "%{value} is not a valid email" }
    validates :age,
              numericality: { greater_than: 0, less_than_or_equal_to: 90,
                              message: "%{value} is not a valid age" }
    validates :gender,
              inclusion: { in: %w[male female],
                           message: "%{value} is not a valid gender" }

    def execute
      user_params = {
        name: name,
        patronymic: patronymic,
        surname: surname,
        email: email,
        age: age,
        nationality: nationality,
        country: country,
        gender: gender
      }
      user = User.create(user_params)
      if user.invalid?
        errors.add(:base, user.errors.full_messages)
        return
      end

      user_interests = Interest.where(name: interests).pluck(:id)
      user_skills = Skill.where(name: skills).pluck(:id)

      user.interests << Interest.find(user_interests)
      user.skills << Skill.find(user_skills)
      user.save
      user
    end

    def email_unique
      if User.exists?(email: email)
        errors.add(:email, "has already been taken")
      end
    end
  end
end

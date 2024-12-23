# frozen_string_literal: true

class UsersController < ActionController::API
  def create
    outcome = Users::Create.run(user_params)

    if outcome.valid?
      render json: { user: outcome.result,
                     message: "User was successfully created." }, status: 201
    else
      render json: { errors: outcome.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :patronymic, :surname, :email, :age, :nationality, :country, :gender,
      interests: [], skills: []
    )
  end
end

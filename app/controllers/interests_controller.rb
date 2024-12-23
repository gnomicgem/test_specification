class InterestsController < ActionController::API
  def create
    interest = Interest.new(interest_params)

    if interest.save
      render json: { interest: interest.as_json(only: [ :id, :name ]),
                     message: "Interest was successfully created." }, status: 201
    else
      render json: { errors: interest.errors.full_messages }, status: 422
    end
  end

  private

  def interest_params
    params.require(:interest).permit(:name)
  end
end

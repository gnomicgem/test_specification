class SkillsController < ActionController::API
  def create
    skill = Skill.new(skill_params)

    if skill.save
      render json: { skill: skill.as_json(only: [ :id, :name ]), message: "Skill was successfully created." },
status: 201
    else
      render json: { errors: skill.errors.full_messages }, status: 422
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:name)
  end
end

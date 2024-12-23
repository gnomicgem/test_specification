class RenameSkilToSkill < ActiveRecord::Migration[7.2]
  def change
    rename_table :skils, :skills
  end
end

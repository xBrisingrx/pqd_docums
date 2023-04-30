class AddCanAuthorizeToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :can_authorize, :boolean, default: false
  end
end

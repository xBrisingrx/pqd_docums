class AddWasSendToClosures < ActiveRecord::Migration[5.2]
  def change
    add_column :closures, :was_send, :boolean, default: false
  end
end

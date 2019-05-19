class ChangeNameToUsers < ActiveRecord::Migration[5.2]
  #変更後の型
  def up
    change_column :users, :name, :string, null: false, default: ""
  end

  #変更前の型
  def down
    change_column :users, :name, :string
  end
end

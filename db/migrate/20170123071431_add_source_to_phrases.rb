class AddSourceToPhrases < ActiveRecord::Migration[5.0]
  def change
    add_column :phrases, :source, :string
    add_column :phrases, :blob,   :text
  end
end

class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.string          :text
      t.string          :category
      t.string          :url
      t.timestamps
    end
  end
end

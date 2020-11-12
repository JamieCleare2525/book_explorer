class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :date_published
      t.string :uid, index: true
      t.string :publisher
      t.timestamps
    end
  end
end

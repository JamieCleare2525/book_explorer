class CreateFileUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :file_uploads do |t|
      t.string :name
      t.string :s3_url
      t.references :user, index: true
      t.string :file
      t.timestamps
    end
  end
end

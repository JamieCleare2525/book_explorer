class FileUpload < ApplicationRecord
  belongs_to :user
  has_many :books
  mount_uploader :file, FileUploader
end

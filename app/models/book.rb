class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :date_published, presence: true
  validates :uid, presence: true
  validates :uid, uniqueness: { message: "'%{value}' has already been taken. Please amend and try again." }
  validates :publisher, presence: true
end

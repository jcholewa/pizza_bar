class Pizza < ApplicationRecord
  validates :name, :ingredients, presence: true
end

class Category < ApplicationRecord
  has_many :words
  has_many :games
end

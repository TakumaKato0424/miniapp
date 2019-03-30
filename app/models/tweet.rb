class Tweet < ApplicationRecord
  validates :text, {presence: true, length:{maximum: 120}}
end

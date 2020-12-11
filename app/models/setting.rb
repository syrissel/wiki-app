class Setting < ApplicationRecord
  validates :logo, presence: true, length: { maximum: 25 }
end

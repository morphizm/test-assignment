class Category < ApplicationRecord
  default_scope { order(title: :asc) }

  has_many :tests, dependent: :nullify
  has_many :badges, class_name: "Badge", foreign_key: "rule_parameter", dependent: :destroy

  validates :title, presence: true
end

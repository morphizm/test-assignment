class Badge < ApplicationRecord
  RULE_NAMES = ['all_test_from_category', 'test_with_one_attempt', 'all_test_with_level']

  belongs_to :test, class_name: "Test", foreign_key: "rule_parameter", optional: true
  belongs_to :category, class_name: "Category", foreign_key: "rule_parameter", optional: true
  has_many :users_badges, dependent: :destroy
  has_many :users, through: :users_badges

  validates :name, presence: true
  validates :picture_file, presence: true
  validates :rule_parameter, presence: true
  validates :rule_name, presence: true, uniqueness: { case_sensitive: false, scope: :rule_parameter }, inclusion: { in: RULE_NAMES }
end

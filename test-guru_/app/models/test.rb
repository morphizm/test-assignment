class Test < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true
  belongs_to :category, optional: true
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  has_many :badges, class_name: "Badge", foreign_key: "rule_parameter", dependent: :destroy

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false, scope: :level }
  validate :validate_timer

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :sort_by_category, ->(name) { joins(:category).where(categories: { title: name }).order('categories.title desc') }
  scope :tests_success, ->(user) { joins(:test_passages).where(test_passages: { successful: true, user: user }) }

  def self.by_category(name)
    sort_by_category(name).pluck(:title)
  end

  private

  def validate_timer
    errors.add(:timer) if timer && timer.min < 0
  end
end

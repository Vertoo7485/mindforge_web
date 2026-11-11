class Exercise < ApplicationRecord
  belongs_to :user, optional: true
  has_many :program_exercises, dependent: :destroy

  validates :name, presence: true
  validates :muscle_group, presence: true

  MUSCLE_GROUPS = {
    'chest' => 'Грудь',
    'back' => 'Спина',
    'legs' => 'Ноги',
    'shoulders' => 'Плечи',
    'arms' => 'Руки',
    'core' => 'Пресс',
    'cardio' => 'Кардио',
    'fullbody' => 'Всё тело'
  }.freeze

  scope :global, -> { where(user_id: nil) }
  scope :for_user, ->(user) { where(user_id: [nil, user.id]) }

  def muscle_group_label
    MUSCLE_GROUPS[muscle_group] || muscle_group
  end

  def is_global?
    user_id.nil?
  end
end
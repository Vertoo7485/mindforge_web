class CharacterController < ApplicationController
  def index
    @character = current_user.character
    @achievements = Achievement.all
    @unlocked_ids = current_user.achievements.pluck(:achievement_id)
  end
end
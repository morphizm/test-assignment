class BadgesController < ApplicationController
  def index
    @badges_user = current_user.badges
    @badges = Badge.all
  end
end

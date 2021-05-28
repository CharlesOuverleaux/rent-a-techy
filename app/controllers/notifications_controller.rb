class NotificationsController < ApplicationController
  def index
    # retrieve not showed notifications
    @notifications = Notification.where(user: current_user, showed: false)
    # set showed true
    @notifications.each do |noti|
      noti.showed = true
      noti.save
    end
    # return json
    render json: @notifications
  end
end
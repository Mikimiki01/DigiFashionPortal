class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    # すでに before_action :set_user で @user をセットしているので、ここでは不要です
  end

  def follow
    if current_user.send_follow_request_to(@user)
      flash[:notice] = "Follow request sent to user."
    else
      flash[:alert] = "Failed to send follow request."
    end
    redirect_to user_path(@user)
  end

  def unfollow
    if current_user.unfollow(@user)
      flash[:notice] = "Unfollowed user."
    else
      flash[:alert] = "Failed to unfollow user."
    end
    redirect_to user_path(@user)
  end

  def accept
    if current_user.accept_follow_request_of(@user)
      flash[:notice] = "Follow request accepted."
    else
      flash[:alert] = "Failed to accept follow request."
    end
    redirect_to user_path(@user)
  end

  def decline
    if current_user.decline_follow_request_of(@user)
      flash[:notice] = "Follow request declined."
    else
      flash[:alert] = "Failed to decline follow request."
    end
    redirect_to user_path(@user)
  end

  def cancel
    if current_user.remove_follow_request_for(@user)
      flash[:notice] = "Follow request canceled."
    else
      flash[:alert] = "Failed to cancel follow request."
    end
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
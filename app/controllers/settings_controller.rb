class SettingsController < ApplicationController
  def index
    if current_user == nil
      redirect_to "/"
    else
      @oakland_tax = Settings.oakland_tax
      @san_bruno_tax = Settings.san_bruno_tax
      @san_rafael_tax = Settings.san_rafael_tax
      @user = current_user
    end
  end
  def update
    Settings[:oakland_tax] = params[:oakland_tax].to_f
    Settings[:san_bruno_tax] = params[:san_bruno_tax].to_f
    Settings[:san_rafael_tax] = params[:san_rafael_tax].to_f
    redirect_to "/settings"
  end
end
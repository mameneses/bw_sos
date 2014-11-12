class SettingsController < ApplicationController
  def index
    @oakland_tax = Settings.oakland_tax
    @san_bruno_tax = Settings.san_bruno_tax
    @san_rafael_tax = Settings.san_rafael_tax
    @user = current_user
  end
  def update
    Settings[:oakland_tax] = params[:oakland_tax]
    Settings[:san_bruno_tax] = params[:san_bruno_tax]
    Settings[:san_rafael_tax] = params[:san_rafael_tax]
    redirect_to "/settings"
  end
end
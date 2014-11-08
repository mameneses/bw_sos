class SettingsController < ApplicationController
  def settings
    @oakland_tax = Settings.tax.oakland
    @san_bruno_tax = Settings.tax.san_bruno
    @san_rafael_tax = Settings.tax.san_rafael
  end
  def update
    Settings.tax.oakland = params[:oakland_tax]
    Settings.tax.san_bruno = params[:san_bruno_tax]
    Settings.tax.san_rafael = params[:san_rafael_tax]
  end
end
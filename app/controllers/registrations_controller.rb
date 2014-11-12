class RegistrationsController < Devise::RegistrationsController

   before_action :configure_permitted_parameters, if: :devise_controller?
   skip_before_filter :require_no_authentication

   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_in){ |u| u.permit(:email, :password) }
     devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:first_name, :last_name,  :email, :password, :password_confirmation, :admin)}
     devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin) }
   end

   def new 
     @user = User.new 
   end

   def update
     self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
     if resource.update_with_password(user_params)
       # if is_navigational_format?
       #   flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
       #   set_flash_message :notice, flash_key
       # end
       sign_in resource_name, resource, :bypass => true
       respond_with resource, :location => after_update_path_for(resource)
     else
       clean_up_passwords resource
       respond_with resource
     end
   end

   def user_params 
     params.require(:user).permit(:email, :password, :current_password, :password_confirmation, :first_name, :last_name, :admin) 
   end
 end
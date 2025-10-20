class Users::SessionsController < Devise::SessionsController
  before_action :ensure_test_admin, only: :new
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      authenticated_root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end

  private

  def ensure_test_admin
    User.find_or_create_by!(email: 'admin@gmail.com') do |user|
      user.name = 'Admin Teste'
      user.password = 'password123'
      user.password_confirmation = 'password123'
      user.role = 'admin'
    end
  rescue => e
    Rails.logger.warn("ensure_test_admin failed: #{e.message}")
  end
end


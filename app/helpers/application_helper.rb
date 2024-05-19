# frozen_string_literal: true

module ApplicationHelper
  def display_header?
    !(current_page?(root_path) ||
      current_page?(new_user_registration_path) ||
      current_page?(new_user_session_path) ||
      current_page?(new_user_confirmation_path) ||
      current_page?(new_user_password_path)
     )
  end
end

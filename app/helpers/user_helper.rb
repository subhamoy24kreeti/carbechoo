module UserHelper
  def my_appointments_link(path)
    link_to ('<i class="fa fa-calendar"></i>my appointments').html_safe, path, class: "dropdown-item"
  end

  def seller_store_link(path)
    link_to ('<i class="fas fa-store"></i>sellers').html_safe, path, class: "dropdown-item"
  end

  def user_settings_link(path)
    link_to ('<i class="fa fa-cog"></i> Settings').html_safe, path, class:"dropdown-item"
  end
end

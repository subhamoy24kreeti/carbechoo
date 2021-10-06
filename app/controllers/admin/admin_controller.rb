class Admin::AdminController < ApplicationController
  before_action :authorize_admin , except: [:get_login_page]

  def get_login_page
    render "admin/login";
  end

  def dashboard
    render "admin/dashboard"
  end

  def all_admin
    @users = User.admins
  end

  def all_buyer
    @users = User.buyers
  end

  def all_seller
    @users = User.sellers
  end

  def cars
    @cars = SellerAppointment.cars
  end

  def user_destroy
    u = User.destroy(id: params[:id])
    if u.is_admin?
      redirect_to admin_all_admin_path, flash: {notice: "Successfully deleted"}
    elsif u.is_seller?
      redirect_to admin_all_seller_path, flash: {notice: "Successfully deleted"}
    else
      redirect_to admin_all_buyer_path, flash: {notice: "Successfully deleted"}
    end
  rescue
    redirect_to admin_all_buyer_path, flash: {error: "there is a problem while deleting"}
  end

  def user_view
    @user = User.find_by_id(params[:id])
  end

end

class Admin::AdminController < ApplicationController
  before_action :authorize_admin , except: [:get_login_page]

  def get_login_page
    render "admin/login";
  end

  def dashboard
    render "admin/dashboard"
  end

  def seller_destroy
    check = User::destroy(params[:id])
    if check
      redirect_to admin_seller_index_path flash: {notice: "Successfully deleted"}
    else
      redirect_to admin_seller_index_path flash: {error: "there is a problem while deleting"}
    end
  end

  def all_admin
    @users = User.where(role: 'admin')
  end

  def all_buyer
    @users = User.where(role: 'buyer')
  end

  def all_seller
    @users = User.where(role: 'seller')
  end

  def cars
    @cars = SellerAppointment.where('status=?', 'approved').order('updated_at DESC')
  end

  def user_destroy
    u = User.where(id: params[:id]).destroy_all
    if !u.blank?
      if u[0].role == 'admin'
        redirect_to admin_all_admin_path, flash: {notice: "Successfully deleted"}
      elsif u[0].role == 'seller'
        redirect_to admin_all_seller_path, flash: {notice: "Successfully deleted"}
      else
        redirect_to admin_all_buyer_path, flash: {notice: "Successfully deleted"}
      end
    else
      redirect_to admin_all_buyer_path, flash: {error: "there is a problem while deleting"}
    end
  end

  def user_view
    @user = User.find_by_id(params[:id])
  end

end

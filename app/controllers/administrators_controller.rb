class AdministratorsController < InheritedResources::Base

  layout "admin"
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  actions :index, :show, :destroy

  access_control do
    allow :admin
  end

  def make
    @user = User.find(params[:id])
    @user.has_role!(:admin)
    flash[:notice] = "Added admin role to user."
    redirect_to administrators_url
  end

  def revoke
    @user = User.find(params[:id])
    @user.has_no_role!(:admin)
    flash[:notice] = "removed admin role from user."
    redirect_to administrators_url
  end

end

class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/', :notice => "Thanks for signing up #{@user.login}!")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def show
    @user = self.current_user
    @clubs = Club.find(:all)
  end

  def update
   # if params[:user].nil? then
    #  params[:user][:club_ids] ||= [] 
    #end #rescue nil
 
    @user = User.find(current_user)
    @clubs = Club.find(:all)
    
    puts params[:user]
    puts @user
 
    if @user.update_attributes params[:user]
        flash[:notice] = "Settings have been SAVED."
        respond_to do |format|
          format.html { render :action => :show}
        end
       # redirect_to edit_user_url(@user)
    else
        flash.now[:error] = @user.errors
        setup_form_values
        respond_to do |format|
          format.html { render :action => :show}
        end
    end
  end

  def edit
    @user = User.find(params[:id])
    @clubs = Club.find(:all)
  end

end

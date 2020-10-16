class MembersController < ApplicationController
  before_action :admin_only

  helper_method :sort_column , :sort_direction 

  def index
    @members = User.order(sort_column + " " + sort_direction)
  end

  def show_threshold_points
    @members = User.where("total_points <= ?", params[:search])
  end


  def show
    @member = User.find(params[:id])

  end

  def new
    @member = User.new
  end

  def create
    @member = User.new(member_params)
    @member.total_points = 0
    @member.meeting_points = 0
    @member.event_points = 0
    @member.misc_points = 0
    @member.encrypted_password = BCrypt::Password.create(Random.new.rand(100.0).to_s)
    send_new_password_email
    if @member.save
      redirect_to(members_path)
    else
      puts @member.valid?
      render('new')
    end
  end

  def edit
    @member = User.find(params[:id])
  end

  def update
    @member = User.find(params[:id])
    if @member.update(member_params)
      redirect_to(member_path(@member))
    else
      flash.alert = "An Error occured. Please check your inputs and try again.\n"
      @member.errors.each{|attr,msg| flash.alert += "#{attr} \t\t #{msg}\n" }
      render('edit')
    end
  end

  def delete
    @member = User.find(params[:id])

  end

  def destroy
    @member = User.find(params[:id])
    @member.destroy
    redirect_to(members_path)
  end

    private
    def member_params
        params.require(:user).permit(:first_name, :last_name, :uin, :email, :total_points, :committee, :subcommittee,:admin)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
    end


    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] :"asc"
    end
end

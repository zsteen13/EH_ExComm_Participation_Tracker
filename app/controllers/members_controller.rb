class MembersController < ApplicationController
  helper_method :sort_column , :sort_direction
  def index
    @members = User.order(sort_column + " " + sort_direction)
  end

  def show
    @member = User.find(params[:id])
  end

  def new
    @member = User.new
  end

  def create
    @member = User.new(member_params)

    if @member.save
      redirect_to(members_path)
    else
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

class CommitteesController < ApplicationController
  def index
    @committees = Committee.all
  end

  def show
    @committee = Committee.find(params[:id])
    @subcommittees = Subcommittee.where(committee: @committee.committee_id)
  end

  def new
    @committee_new = Committee.new
  end

  def edit
    @committee = Committee.find(params[:id])
  end

  def update
    @committee = Committee.find(params[:id])
    if @committee.update(committee_params)
      redirect_to(committees_path)
    else
      flash.alert = "An Error occured. Please check your inputs and try again.\n"
      @committee.errors.each { |attr, msg| flash.alert += "#{attr} \t\t #{msg}\n" }
      render('edit')
    end
  end

  def create
    @committee = Committee.new(committee_params)
    @committee_prev = Committee.last
    @committee.committee_id = if !@committee_prev.nil?
                                @committee_prev.committee_id + 1
                              else
                                0
                              end
    if @committee.save
      redirect_to(committees_path)
    else
      flash.alert = "An Error occured. Please check your inputs and try again.\n"
      @committee.errors.each { |attr, msg| flash.alert += "#{attr} \t\t #{msg}\n" }
      render('new')
    end
  end

  def delete
    @committee = Committee.find(params[:committee_id])
  end

  def destroy
    @committee = Committee.find(params[:id])
    @committee.destroy
    redirect_to(committees_path)
  end

  private

  def committee_params
    params.require(:committee).permit(:committee, :point_threshold, :head_first_name, :head_last_name, :email)
  end
end

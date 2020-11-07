# frozen_string_literal: true

# Committees Controller
class CommitteesController < ApplicationController
  before_action :admin_only

  def index
    @committees = Committee.all
  end

  def show
    @committee = Committee.find(params[:id])
    @users = User.where(committee: @committee.id)
  end

  def new
    @committee = Committee.new
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
      render(:edit)
    end
  end

  def create
    @committee = Committee.new(committee_params)
    @committee_prev = Committee.last
    @committee.id = if !@committee_prev.nil?
                      @committee_prev.id + 1
                    else
                      0
                    end
    if @committee.save
      redirect_to(committees_path)
    else
      flash.alert = "An Error occured. Please check your inputs and try again.\n"
      @committee.errors.each { |attr, msg| flash.alert += "#{attr} \t\t #{msg}\n" }
      render(:new)
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

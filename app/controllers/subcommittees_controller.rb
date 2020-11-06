# frozen_string_literal: true

# Subcommittees Controller
class SubcommitteesController < ApplicationController
  before_action :admin_only
  def index
    @committee = Committee.find(params[:committee_id])
    @subcommittees = Subcommittee.where(committee: @committee.id)
  end

  def show
    @subcommittee = Subcommittee.find(params[:id])
    @users = User.where(subcommittee: params[:id])
  end

  def new
    @committee = Committee.find(params[:committee_id])
    @subcommittee_new = Subcommittee.new
  end

  def edit
    @subcommittee = Subcommittee.find(params[:id])
  end

  def update
    @subcommittee = Subcommittee.find(params[:id])
    if @subcommittee.update(subcommittee_params)
      redirect_to(committee_subcommittees_path(@subcommittee.committee))
    else
      flash.alert = "An Error occured. Please check your inputs and try again.\n"
      @subcommittee.errors.each { |attr, msg| flash.alert += "#{attr} \t\t #{msg}\n" }
      render('edit')
    end
  end

  def create
    @subcommittee = Subcommittee.new(subcommittee_params)
    @subcommittee.committee = params[:committee_id]
    @subcommittee_prev = Subcommittee.last
    if !@subcommittee_prev.nil?
      @subcommittee.id = @subcommittee_prev.id + 1
    else
      0
    end
    if @subcommittee.save
      redirect_to(committee_subcommittees_path)
    else
      flash.alert = "An Error occured. Please check your inputs and try again.\n"
      @subcommittee.errors.each { |attr, msg| flash.alert += "#{attr} \t\t #{msg}\n" }
      render('new')
    end
  end

  def delete
    @subcommittee = Subcommittee.find(params[:subcommittee_id])
    @committee = Committee.find(@subcommittee.committee)
  end

  def destroy
    @subcommittee = Subcommittee.find(params[:id])
    @subcommittee.destroy
    redirect_to(committee_subcommittees_path(@subcommittee.committee))
  end

  private

  def subcommittee_params
    params.require(:subcommittee).permit(:subcommittee, :point_threshold, :committee)
  end
end

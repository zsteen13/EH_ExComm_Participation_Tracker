# frozen_string_literal: true

require 'securerandom'
require 'pp'

# MembersController
class MembersController < ApplicationController
  before_action :admin_only

  helper_method :sort_column, :sort_direction

  def index
    @members = if params[:below]
                 User.where('total_points <= ?', params[:search]).order("#{sort_column} #{sort_direction}")
               elsif params[:above]
                 User.where('total_points >= ?', params[:search]).order("#{sort_column} #{sort_direction}")
               else
                 User.order("#{sort_column} #{sort_direction}")
               end
  end

  def show
    @member = User.find(params[:id])
  end

  def new
    @member = User.new
  end

  def create
    @member = User.new(member_params)
    @member.meeting_points = 0
    @member.event_points = 0
    @member.misc_points = 0
    @member.password_digest = BCrypt::Password.create(Random.new.rand(100.0).to_s)

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
      update_members_point_threshold(@member)
      redirect_to(member_path(@member))
    else
      flash.alert = "An Error occured. Please check your inputs and try again.\n"
      @member.errors.each { |attr, msg| flash.alert += "#{attr} \t\t #{msg}\n" }
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

  def subcommittees_by_committee
    @subcommittees = Subcommittee.where(committee: params[:committee_id])
    respond_to do |format|
      format.json { render json: @subcommittees }
    end
  end

  def point_threshold
    @current_point_threshold_value = Constant.where(name: 'point_threshold_value').take.value
  end

  def update_point_threshold
    @threshold = Constant.where(name: 'point_threshold_value')
    if !@threshold.update(value: params[:point_threshold_value])
      flash.alert = "An Error occured.\n"
      redirect_to '/members/point_threshold'
    else
      flash.alert = "Value Successfully Updated!\n"
      redirect_to '/members/point_threshold'
      update_member_point_thresholds(params[:point_threshold_value])
    end
  end

  def update_member_point_thresholds(new_value)
    User.where(committee: nil).update_all(point_threshold: new_value)
  end

  def update_members_point_threshold(member)
    if member.committee.blank? && member.subcommittee.blank?
      # reset to default
      member.update(point_threshold: Constant.where(name: 'point_threshold_value').take.value)
    elsif !member.subcommittee.blank?
      # update point threshold if member is in a subcommittee
      member.update(point_threshold: Subcommittee.where(id: member.subcommittee).take.point_threshold)
    else
      # update point threshold if member is in a committee
      member.update(point_threshold: Committee.where(id: member.committee).take.point_threshold)
    end
  end

  private

  def member_params
    params.require(:user).permit(:first_name, :last_name, :uin, :email, :total_points, :committee, :subcommittee, :admin)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'first_name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end

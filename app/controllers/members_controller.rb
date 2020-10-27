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
    @committees = Committee.all
    @subcommittees = Subcommittee.all
  end

  def create
    @member = User.new(member_params)
    @member.total_points = 0
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
    @committees = Committee.all
    @subcommittees = Subcommittee.all
  end

  def update
    @member = User.find(params[:id])
    if @member.update(member_params)
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

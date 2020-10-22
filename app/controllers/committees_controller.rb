# frozen_string_literal: true

# Committees Controller
class CommitteesController < ApplicationController
  def index
    @committees = Committee.all
  end
end

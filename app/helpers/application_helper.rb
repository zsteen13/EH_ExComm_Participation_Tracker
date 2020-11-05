# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def sortable(column, title)
    css_class = title == sort_column ? "current #{sort_direction}" : nil
    direction = title == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to column, request.query_parameters.merge({ sort: title, direction: direction }), { class: css_class }
  end
end

def arrow(column)
  # as you're not sorting on the column, you don't want to see the arrow at
  # all of the header is not for the sorted column
  return  if params[:sort] != column
  # ...
end

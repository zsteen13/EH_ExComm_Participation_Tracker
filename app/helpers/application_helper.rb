module ApplicationHelper
  def sortable(column, title)
    direction = title == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to column, :sort => title, :direction => direction
  end
end

module ApplicationHelper
  def pagination_params(obj)
    {
      current_page: obj.current_page,
      next_page: obj.next_page,
      prev_page: obj.prev_page,
      total_pages: obj.total_pages,
      total_count: obj.total_count,
    }
  end
end

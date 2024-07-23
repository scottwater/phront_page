# frozen_string_literal: true

class Blog::Pager::Component < Blog::BlogViewComponent
  option :url, optional: true
  option :next, default: proc { true }

  def paged_url
    url || request.url
  end

  def current_page
    @current_page ||= begin
      uri = URI.parse(paged_url)
      query_params = Rack::Utils.parse_query(uri.query)
      (query_params["page"] || 1).to_i
    end
  end

  def next_page_url
    @next_page_url ||= begin
      uri = URI.parse(paged_url)
      query_params = Rack::Utils.parse_query(uri.query)
      query_params["page"] = next_page
      uri.query = query_params.to_query
      # uri.to_s
      "#{uri.path}?#{uri.query}"
    end
  end

  def previous_page_url
    @previous_page_url ||= begin
      uri = URI.parse(paged_url)
      query_params = Rack::Utils.parse_query(uri.query)
      query_params["page"] = previous_page
      uri.query = query_params.to_query
      # uri.to_s
      "#{uri.path}?#{uri.query}"
    end
  end

  def previous_page?
    current_page > 1
  end

  def next_page
    current_page + 1
  end

  def previous_page
    current_page - 1
  end

  def next?
    !!self.next
  end
end

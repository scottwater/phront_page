module ApplicationHelper
  def component_class(name)
    name.to_s.camelize.constantize::Component
  end

  def component(name, *, **, &)
    component = component_class(name)
    render(component.new(*, **), &)
  end
  alias_method :c, :component

  def svg(name, **)
    inline_svg_tag("svgs/#{name}.svg", **)
  end

  def svg_embeded(svg_string, klass: nil)
    Content::EmbeddedSvg.merge(svg_string, klass)
  end

  def present_all(records, presenter = nil)
    records.map { |record| presenter ? present(presenter, record) : present(record) }
  end
end

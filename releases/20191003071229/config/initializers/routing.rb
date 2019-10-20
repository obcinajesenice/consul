class ActionDispatch::Routing::Mapper
  def draw(route_file)
    instance_eval(File.read(Rails.root.join("config/routes/#{route_file}.rb")))
  end
end

RouteTranslator.config do |config|
  config.force_locale = true
  generate_unlocalized_routes = true
end
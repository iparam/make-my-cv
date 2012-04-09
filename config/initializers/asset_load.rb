ActionController::Base.asset_host = Proc.new { |source, request|
  if request.env["REQUEST_PATH"].include? ".pdf"
    "file://#{Rails.root.join('public','stylesheets')}"
  end
}

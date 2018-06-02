module Helper
  extend ActiveSupport::Concern

  def bittrex_url(url_string, url_args)
    params = {}
    params = params.merge!(url_args) if url_args.present?
    replaced_string = url_string % params
    replaced_string.gsub(/ |\n/, "")
  end
end

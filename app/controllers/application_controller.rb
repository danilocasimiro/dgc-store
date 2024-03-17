class ApplicationController < ActionController::API
  include Api::V1::Concerns::JwtToken
  include Api::V1::Concerns::HandleErrors
  include Api::V1::Concerns::PaginationSerializer

  def model_class
    controller_name.classify.constantize
  end

  def include_associations
    return unless params[:expand]

    expand_params = params[:expand].split(',').map(&:to_sym)
    model_class.relation_map.select { |item| expand_params.include?(item) }
  end
end

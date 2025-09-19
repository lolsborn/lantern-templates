class Api::V1::BaseController < ApplicationController
  include Pagy::Backend

  private

  def pagination_meta(pagy)
    {
      current_page: pagy.page,
      per_page: pagy.vars[:items],
      total_pages: pagy.pages,
      total_count: pagy.count
    }
  end

  def render_collection(collection, serializer_class, pagy = nil)
    data = serializer_class.new(collection).serializable_hash

    if pagy
      data[:meta] = pagination_meta(pagy)
    end

    render json: data
  end

  def render_resource(resource, serializer_class, status = :ok)
    render json: serializer_class.new(resource).serializable_hash, status: status
  end
end
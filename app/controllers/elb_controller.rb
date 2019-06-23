class ElbController < ApplicationController
  def health
    render text:'ok'
  end
end

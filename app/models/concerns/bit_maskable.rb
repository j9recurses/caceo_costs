module BitMaskable
  extend ActiveSupport::Concern

  module ClassMethods
    def bit_mask_pipeline
      @bit_mask_pipeline ||= []
    end

    def append_to_bit_mask_pipeline(proc)
      bit_mask_pipeline.push(proc)
    end
  end

  # uses @survey_id from ResponseFormBuilder
  included do
    bit_mask_fields.each do |field|
      options = "#{survey_id}::#{field.upcase}".constantize
      virtual_field = "#{field}_multi_select"

      # Form Instance method used to populate the virtual fields
      define_method( virtual_field ) do
        options.reject { |l| ( ( self.model.send( field ) || 0) & 2**options.index(l)).zero? }
      end

      # Form Class Instance pipeline
      # called by #process_bit_masks before validating
      bit_mask_setter = Proc.new do | params |
        bit_selection = ( ((params['response_attributes'][virtual_field] || []) & options).map { |l| 2**options.index(l) }.sum )
        params['response_attributes'][field] = bit_selection
        params
      end
      append_to_bit_mask_pipeline( bit_mask_setter )
    end
  end

  # FORM Instance method
  def process_bit_masks(params)
    if params['response_attributes']
      self.class.bit_mask_pipeline.each do |proc|
        params = proc.call(params)
      end
    end
    params
  end
end
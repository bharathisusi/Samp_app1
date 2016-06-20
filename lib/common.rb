module Common
  extend ActiveSupport::Concern

  module ClassMethods
    def show_history(num)
      where("history_id IS NULL AND id =? OR history_id =? AND id != ?", num, num, num).order("id DESC").first
    end

    def list_comment_history(num)
      where(id: num).first.histories.order("id DESC")
    end
  end

  def check_history?
    self.histories.blank?
  end

  def get_object_table_name
    self.class.name.singularize.classify.constantize.table_name
  end

  def get_class_name
    self.class.name
  end

end
